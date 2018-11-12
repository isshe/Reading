%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR  ; 0x900

    ;构建gdt及其内部描述符
GDT_BASE:
    dd      0x00000000
    dd      0x00000000              ;最开始的描述符不使用
CODE_DESC: 
    dd      0x0000FFFF
    dd      DESC_CODE_HIGH4         ;代码段
DATA_STACK_DESC:
    dd      0x0000FFFF              ;数据/堆栈段
    dd      DESC_DATA_HIGH4         
VIDEO_DESC:
    dd      0x80000007              ; limit=(0xbffff-0xb8000)/4k=0x7, 这里是7页吗？
    dd      DESC_VIDEO_HIGH4        ; 0xb8000-0x00或0x01bffff是文本模式显示适配器
                                        ; 高位中有0x0b
    GDT_SIZE    equ     $ - GDT_BASE    ; 32 = 4 * 8
    GDT_LIMIT   equ     GDT_SIZE - 1

    times 60 dq 0                        ; 预留60个，dq=8字节

    ; 相当于(CODE_DESC - GDT_BASE)/8 + TI_GDT + RPL0
    SELECTOR_CODE   equ (0x0001<<3) + TI_GDT + RPL0         ; 第一个描述符     
    SELECTOR_DATA   equ (0x0002<<3) + TI_GDT + RPL0         ; 第二个描述符
    SELECTOR_VIDEO  equ (0x0003<<3) + TI_GDT + RPL0

    ;保存内存容量
    total_mem_bytes dd 0

    gdt_ptr dw GDT_LIMIT        ;2字节
            dd GDT_BASE         ;4字节，GDT起始地址

    ; 人工对齐：total_mem_bytes(4) + gdt_ptr(6) + ards_buf(244) + ards_nr(2) = 256字节
    ards_buf times 244 db 0     ; 244字节，244/20 = 12，那么最多能记录12个ARDS结构喽？
    ards_nr dw 0

;-----------------------------------------------------------------
; int 15h eax = 0x0000E820, edx = 0x534D4150('SMAP')，获取内存布局
;-----------------------------------------------------------------
loader_start:
    xor ebx, ebx            ; 清零
    mov edx, 0x534d4150     ; SMAP
    mov di, ards_buf        ; ards结构缓冲区。这里这样有什么用？
.e820_mem_get_loop:         ; 循环获取内个ARDS内存范围描述结构？？？
    mov eax, 0x000e820      ; 
    mov ecx, 20             ; ARDS地址范围描述符结构大小是20字节
    int 0x15
    jc .e820_failed_so_try_e801     ; e820失败了，尝试e801
    ;下面是成功的
    add di, cx              ; 这里是否可以加ecx？
    inc word [ards_nr]      ; 记录ARDS的数量
    cmp ebx, 0              ; ebx = 0 & cf != 1, 说明ARDS全部返回了
    jnz .e820_mem_get_loop  ; 不为0继续循环

    mov cx, [ards_nr]       ; 设置循环次数，从中找最大的
    mov ebx, ards_buf
    xor edx, edx            ; edx保存最大的内容容量，也就是结构
.find_max_mem_area:
    mov eax, [ebx]          ; base_add_low ???
    add eax, [ebx + 8]      ; length_low
    add ebx, 20             ; 下一个

    cmp edx, eax            ; 看哪个大
    jge .next_ards          ; edx更大，继续下一个，否则更新edx
    mov edx, eax            ; 更新edx
.next_ards:
    loop .find_max_mem_area
    jmp .mem_get_ok         ; 到这里为止，e820获取内存布局完成

;-------------------------------------------------------------------
; int 15h ax = 0xe801 获取内存大小，最大支持4G
; 返回后，ax/cx的值一样，以KB为单位；bx/dx的值一样，以64KB为单位
; 在ax和cx寄存器中为低16MB，在bx和dx寄存器中为16M到4G
;-------------------------------------------------------------------
.e820_failed_so_try_e801:
    mov ax, 0xe801 
    int 0x15
    jc .e801_failed_so_try88 ; 失败了，继续下一个方法

    ;1.先算出低15M的内存，ax和cx中以KB为单位，将其转换为byte
    mov cx, 0x400            ; 0x400 = 1Kk
    mul cx                   ; ax * cx
    shl edx, 16              ; 乘积的高16位在edx的低16位中，移动结果到高位
    and eax, 0x0000FFFF      ; 乘积的低16位在eax的低16位中 
    or edx, eax                 
    add edx, 0x100000        ; 1M, ax只是15M，因此要加1M，这个1M是预留给什么来者？？？
    mov esi, edx             ; 结果暂时保存到esi

    ;2.将16MB以上的内存转换为byte单位，bx和dx中是以64KB为单位的
    xor eax, eax 
    mov ax, bx
    mov ecx, 0x10000         ; 64KB
    mul ecx                  ; eax * ecx,结果在edx和eax
    add esi, eax             ; 总内存
    
    mov edx, esi             ; 保存回edx
    jmp .mem_get_ok

;--------------------------------------------------------------------
; int 0x15, ah = 0x88, 获取内存大小，只能获取64MB以内
;--------------------------------------------------------------------
.e801_failed_so_try88:
    mov ah, 0x88 
    int 0x15 
    jc .error_hlt           ; 出错了
    and eax, 0x0000FFFF     ; 没有出错，继续

    mov cx, 0x400 
    mul cx                  ; ax * cx
    shl edx, 16
    ;and eax, 0x0000FFFF    ; 这个放这里也可以吧？尝试！！！！！
    or edx, eax             ; 相加
    add edx, 0x100000       ; 实际内存 +1MB

.mem_get_ok:
    mov [total_mem_bytes], edx      ; 保存

;--------------------------------------------------------------------
; 准备进入保护模式
; 1. 打开A20地址线
; 2. 加载GDT
; 3. 将cr0的pe位置1
;--------------------------------------------------------------------
    ;1.打开A20地址线
    in al, 0x92             ; 取出来
    or al, 0000_0010B       ; 设置
    out 0x92, al            ; 放回去

    ;2.加载GDT
    lgdt [gdt_ptr] 

    ;3.CR0第0位置1
    mov eax, cr0
    or eax, 0x00000001
    mov cr0, eax

    jmp dword SELECTOR_CODE:p_mode_start    ; 刷新流水线

.error_hlt:
    hlt                     ; 出错，挂起

;下面就是保护模式了
[bits 32]
p_mode_start:
    mov ax, SELECTOR_DATA
    mov ds, ax
    mov es, ax
    mov ss, ax 
    mov esp, LOADER_STACK_TOP   ;
    mov ax, SELECTOR_VIDEO 
    mov gs, ax                  ; gs，显示内存？？？


; -------------------------   加载kernel  ----------------------
    mov eax, KERNEL_START_SECTOR        ; kernel.bin所在的扇区号
    mov ebx, KERNEL_BIN_BASE_ADDR       ; 从磁盘读出后，写入到ebx指定的地址
    mov ecx, 200			            ; 读入的扇区数

    call rd_disk_m_32


    call setup_page

    sgdt [gdt_ptr]
    
    ;将gdt描述符表中视频段描述符中的段基址+0xc0000000
    mov ebx, [gdt_ptr + 2]
    or dword [ebx + 0x18 + 4], 0xc0000000       ; 0x18=24,3*8,段描述符的高4字节是段基址的31～24位

    ;将gdt的基址+0xc0000000使其成为内核所在的高地址
    add dword [gdt_ptr + 2], 0xc0000000         ; gdt_ptr后2字节是段限制，再后4字节是基址
    add esp, 0xc0000000                         ; 栈指针映射到内核地址

    ;将页目录地址赋值给cr3
    mov eax, PAGE_DIR_TABLE_POS
    mov cr3, eax

    ;打开分页模式，cr0的pg(31位)置1
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    ;开启分页后，用gdt新的地址重新加载
    lgdt [gdt_ptr]                              ; 重新加载

;   mov byte [gs:160], 'V'      
    
;   jmp $
; 以防万一
    jmp SELECTOR_CODE:enter_kernel              ; 强制刷新流水线

enter_kernel:
    call kernel_init
    mov esp, KERNEL_STACK_BOTTOM
    jmp KERNEL_ENTRY_POINT

;将kernel.bin中的segment拷贝到编译的地址
kernel_init:
    xor eax, eax 
    xor ebx, ebx            ; ebx 记录程序头表地址
    xor ecx, ecx            ; cx 记录程序头表中的program header的数量
    xor edx, edx            ; dx 记录program header尺寸，即e_phentsize

    mov dx, [KERNEL_BIN_BASE_ADDR + 42]         ; 偏移文件42字节是e_phentsize
    mov ebx, [KERNEL_BIN_BASE_ADDR + 28]        ; 偏移文件28字节是e_phoff,第一个program header在文件中的偏移量
    add ebx, KERNEL_BIN_BASE_ADDR
    mov cx, [KERNEL_BIN_BASE_ADDR + 44]         ; 偏移文件44字节是e_phnum,有几个program header

.each_segment:
    cmp byte [ebx + 0], PT_NULL                 ; p_type==PT_NULl说明此段没有在使用
    je .PTNULL

    ; 此段在使用，则执行下面的
    ; 为函数memcpy压入参数，参数从由往左依次压入，函数原型类似memcpy(dst, src, size)
    push dword [ebx + 16]                       ; program header 偏移16字节是p_filesz
    mov eax, [ebx + 4]                          ; program header 偏移4字节是p_offset
    add eax, KERNEL_BIN_BASE_ADDR               ; 加上kernel.bin被加载的物理地址，eax为该段的物理地址
    push eax                                    ; 源地址
    push dword [ebx + 8]                        ; 目的地址，p_vaddr,这个不是虚拟地址吗？？？这里分页不是还没开吗？？？
    call mem_cpy
    add esp, 12                                 ; 清理栈

.PTNULL:
    add ebx, edx                                ; edx为program header大小，即e_phentsize
    loop .each_segment
    ret 

mem_cpy:
    cld
    push ebp
    mov ebp, esp
    push ecx                                    ; rep 指令用到ecx，但外层循环还在用，所以备份

    mov edi, [ebp + 8]                          ; 目的地址
    mov esi, [ebp + 12]                         ; 源地址
    mov ecx, [ebp + 16]                         ; 数量
    rep movsb

    ; 恢复环境
    pop ecx
    pop ebp
    ret

; 这个代码只是关于分页功能的一部分
; 这个代码完成的是群速内存分页机制的第一步：准备号页目录和页表。

;----------------------------------------------------------
;创建页目录和页表
;----------------------------------------------------------
setup_page:
    ;把页目录占用的空间全部清0
    mov ecx, 4096       ; 4KB
    mov esi, 0
.clear_page_dir:
    mov byte [PAGE_DIR_TABLE_POS + esi], 0
    inc esi
    loop .clear_page_dir

;开始创建页目录项(PDE, Page Directory Entry)
.create_pde:
    mov eax, PAGE_DIR_TABLE_POS ; 0x100000
    add eax, 0x1000             ; 4K, 第一个页表的位置和属性
    mov ebx, eax                ; 为.create_pte做准备，ebx为基址
    
;将页目录项第1和第0x300(768)项都存为第一个页表的地址，第0x300项对应的地址是0xc00！
;每个页表表示4MB内存（0x3FFFFF）【1个页目录项对应1024个页表，一个页表4M，共4G】
;这样0xc03fffff以下的地址(???)和0x003fffff以下的地址(???)都指向相同的页表，
;这是为将地址映射为内核地址做准备
    ;页目录项的属性RW/P/US为1，US位为1表示用户属性，所有特权级别都可以访问这些属性
    ;页目录表的第1项和768项写入第一个页表的地址(0x101000)和属性(7)
    ;0xc00以上的目录项用于内核空间，也就是页表的0xc0000000 ～ 0xffffffff共计1GB属于内核
    ;0x0 ~ 0xbfffffff共计3GB属于用户进程
    or eax, PG_US_U | PG_RW_W | PG_P
    mov [PAGE_DIR_TABLE_POS + 0x0], eax         ; 第1项
    mov [PAGE_DIR_TABLE_POS + 0xc00], eax       ; 0xc00是第768项的偏移(769???)

    ;使最后一个目录项指向页目录表自己的地址
    sub eax, 0x1000
    mov [PAGE_DIR_TABLE_POS + 4092], eax        ; 4092 ????????!!!!!! 4092=0xFFC
                                                ; 使最后一个目录项指向页目录表自己的地址,4096-4=4092!一个项4字节
;下面创建页表项(PTE, Page Table Entry)
    mov ecx, 256                                ; 1M低端内存/4K每页 = 256项(只使用低端的1M内存)
    mov esi, 0
    mov edx, PG_US_U | PG_RW_W | PG_P           ; 0x7!
.create_pte:
    mov [ebx+esi*4], edx
    add edx, 4096                               ; = 0x1000, = 4K
    inc esi
    loop .create_pte

;创建内核其他页表的页目录项(PDE)
    mov eax, PAGE_DIR_TABLE_POS
    add eax, 0x2000                             ; 此时eax为第二个页表的位置
    or eax, PG_US_U | PG_RW_W | PG_P            ; 
    mov ebx, PAGE_DIR_TABLE_POS 
    mov ecx, 254                                ; 第769~1022目录项的数量
    mov esi, 769
.create_kernel_pde:
    mov [ebx+esi*4], eax
    inc esi 
    add eax, 0x1000                             ; 下一个
    loop .create_kernel_pde
    ret

;------------------------------------------------------------------------------------
; 功能：读磁盘n个扇区
; 参数： eax = LBA扇区号
;       ebx = 写入数据的内存地址
;       ecx = 读入扇区数量
;------------------------------------------------------------------------------------
rd_disk_m_32:
    mov esi, eax    ; 备份eax
    mov di, cx,     ; 备份cx

; 写硬盘
    ; 第一步：设置要读取的扇区数
    mov dx, 0x1f2           ;读硬盘的地址
    mov al, cl 
    out dx, al              ; 读取的扇区数
    mov eax, esi            ; 恢复eax

    ; 第二步：将LBA地址存入0x1f3~0x1f6
    
    ; LBA地址7~0位写入端口0x1f3
    mov dx, 0x1f3
    out dx, al

    ; LBA地址15~8位写入端口0x1f4
    mov cl, 8
    shr eax, cl
    mov dx, 0x1f4
    out dx, al

    ; LBA地址23~16位写入端口0x1f5
    shr eax, cl
    mov dx, 0x1f5
    out dx, al 

    shr eax, cl
    and al , 0x0f   ; LBA 24~27位
    or al, 0xe0     ; 7~4位设置为1110，表示LBA模式
    mov dx, 0x1f6
    out dx, al

    ; 第三步：想0x1f7端口写入读命苦，0x20
    mov dx, 0x1f7
    mov al, 0x20
    out dx, al

    ; 第四步： 检测数据准备状态：测试0x1f7端口(status寄存器)的BSY位
.not_ready:
    nop
    in al, dx
    and al, 0x88
    cmp al, 0x08
    jnz .not_ready

    ; 第五步：从0x1f0端口读数据
    mov ax, di                  ; di要读取的扇区数，一个扇区512字节
    mov dx, 256                 ; 一次读一个字，读256次为一个扇区
    mul dx                      ; 总读取次数得到，在ax中？！
    mov cx, ax                  ; 给cx
    mov dx, 0x1f0

.go_on_read:
    in ax, dx
    mov [ebx], ax
    add ebx, 2 
    		    ; 由于在实模式下偏移地址为16位,所以用bx只会访问到0~FFFFh的偏移。
			    ; loader的栈指针为0x900,bx为指向的数据输出缓冲区,且为16位，
			    ; 超过0xffff后,bx部分会从0开始,所以当要读取的扇区数过大,待写入的地址超过bx的范围时，
			    ; 从硬盘上读出的数据会把0x0000~0xffff的覆盖，
			    ; 造成栈被破坏,所以ret返回时,返回地址被破坏了,已经不是之前正确的地址,
			    ; 故程序出会错,不知道会跑到哪里去。
			    ; 所以改为ebx代替bx指向缓冲区,这样生成的机器码前面会有0x66和0x67来反转。
			    ; 0X66用于反转默认的操作数大小! 0X67用于反转默认的寻址方式.
			    ; cpu处于16位模式时,会理所当然的认为操作数和寻址都是16位,处于32位模式时,
			    ; 也会认为要执行的指令是32位.
			    ; 当我们在其中任意模式下用了另外模式的寻址方式或操作数大小(姑且认为16位模式用16位字节操作数，
			    ; 32位模式下用32字节的操作数)时,编译器会在指令前帮我们加上0x66或0x67，
			    ; 临时改变当前cpu模式到另外的模式下.
			    ; 假设当前运行在16位模式,遇到0X66时,操作数大小变为32位.
			    ; 假设当前运行在32位模式,遇到0X66时,操作数大小变为16位.
			    ; 假设当前运行在16位模式,遇到0X67时,寻址方式变为32位寻址
			    ; 假设当前运行在32位模式,遇到0X67时,寻址方式变为16位寻址.

    loop .go_on_read
    ret