    %include "boot.inc"
    section loader vstart=LOADER_BASE_ADDR
    LOADER_STACK_TOP equ LOADER_BASE_ADDR   ; 注意这个是反向生长
    ;jmp loader_start

; 构建gdt及其内部的描述符
    GDT_BASE:                   ; 没用！
        dd 0x00000000   
        dd 0x00000000
    CODE_DESC:                  ; 代码段描述符
        dd 0x0000FFFF           ; 前面16位是段基址，后面的16位段界限
        dd DESC_CODE_HIGH4      ; 这里段界限还有4位1
    DATA_STACK_DESC:
        dd 0x0000FFFF
        dd DESC_DATA_HIGH4      ;
    VIDEO_DESC:                 ; 这个不是很懂!!!???
        dd 0x80000007           ; 段界限=(0xbffff-0xb8000)/4k = 0x7， 4k = 0x1000
                                ; 0xb8000-0x00或0x01bffff是文本模式显示适配器
        dd DESC_VIDEO_HIGH4     ; 高位中有0x0b

    GDT_SIZE equ $ - GDT_BASE
    GDT_LIMIT equ GDT_SIZE - 1
    times 60 dq 0               ; 预留60个描述符的空位！！！

    ; 以下3个选择子不明白：0x0001代表第1个描述符，也就是CODE_DESC!
    SELECTOR_CODE equ (0x0001 << 3) + TI_GDT + RPL0     ; TI_GDT使用全局描述符
    ; 上面一句相当于：   (CODE_DESC - GDT_BASE) / 8 + TI_GDT + RPL0
    SELECTOR_DATA equ (0x0002 << 3) + TI_GDT + RPL0
    SELECTOR_VIDEO equ (0x0003 << 3) + TI_GDT + RPL0

    ; 用于保存内存容量，以字节为单位
    ; 当前偏移loader.bin文件头0x200字节(512 = 64×8???)，
    ; loader.bin的加载地址是0x900，故total_mem_bytes内存中的地址是0xb00
    ; 将来在内核中会引用此地址
    total_mem_bytes dd 0

    ; 以下是gdt的指针，前2字节是gdt界限，后四字节是gdt起始地址
    gdt_ptr     dw GDT_LIMIT
                dd GDT_BASE

    ; 人工对齐：total_mem_bytes(4) + gdt_ptr(6) + ards_buf(244) + ards_nr(2) = 256字节
    ards_buf times 244 db 0
    ards_nr dw 0                ; ???记录多少个ards?

;----------------------------------------------------------------------
; INT 0x15, eax = 0x0000E820, edx = 0x534D4150("SMAP")，功能：获取内存布局
;----------------------------------------------------------------------
loader_start:
    xor ebx, ebx    ; 清零
    mov edx, 0x534d4150
    mov di, ards_buf

.e820_mem_get_loop:
    mov eax, 0x0000e820     ; 更新子功能号,因为执行完int 0x15后，eax会变为0x534d4150
    mov ecx, 20             ; ARDS地址范围描述符结构大小是20字节
    int 0x15
    jc .e820_failed_so_try_e801     ; 检查cf位是否为1，为1则有错误发生，尝试0xe801子功能
    add di, cx              ; 使di增加20字节指向缓冲区中新的ARDS结构位置
    inc word [ards_nr]      ; 自增，记录ARDS数量
    cmp ebx, 0              ; 若ebx为0且cf不为1， 说明当前已经是最后一个
    jnz .e820_mem_get_loop  ; 不是最后一个，继续循环

;在所有ards结构中找出(base_add_low + length_low)的最大值，即内存容量
    ; 遍历每一个ards结构体，循环次数是ards的数量:ards_nr
    mov cx, [ards_nr]
    mov ebx, ards_buf
    xor edx, edx            ; 清零

.find_max_mem_area:
    ; 无需判断type是否为1，最大的内存块一定是可被使用的
    mov eax, [ebx]      ; ???base_add_low
    add eax, [ebx + 8]  ; ???length_low
    add ebx, 20         ; 指向缓冲区中下一个ARDS结构
    cmp edx, eax
    jge .next_ards      ;找出最大
    mov edx, eax        ;edx为总内存大小???不是最大？？？
.next_ards:
    loop .find_max_mem_area
    jmp .mem_get_ok

;-------------------------------------------------------------------
; int 15h ax = 0xe801 获取内存大小，最大支持4G
; 返回后，ax/cx的值一样，以KB为单位；bx/dx的值一样，以64KB为单位
; 在ax和cx寄存器中为低16MB，在bx和dx寄存器中为16M到4G
;-------------------------------------------------------------------
.e820_failed_so_try_e801:
    mov ax, 0xe801
    int 0x15 
    jc .e801_failed_so_try88

;1.先算出第15M内存
; ax和cx中是以KB为单位的内存数量，将其转换为byte(B)为单位
    mov cx, 0x400   ; 1024
    mul cx          ; ax * cx, ax*16位，结果存在：高16位存在dx中，低16位存在ax中
    shl edx, 16     ; 左移16位，把乘积的高16位移动到edx的高位（目的是把整个结果存在edx中），乘积的高16位在edx的低16位中
    and eax, 0x0000FFFF     ; 乘积低16位在eax的低16位中
    or edx, eax     ; 为什么不直接add？
    add edx, 0x100000   ;ax只是15MB,故要加1MB？？？！！！
    mov esi, edx 

;2.将16MB以上的内存转换为byte为单位
; 寄存器bx和dx中是以64KB为单位的内存数量
    xor eax, eax        ; 清零
    mov ax, bx
    mov ecx, 0x10000    ; 十进制为64KB
    mul ecx             ; eax * ecx，结果在 edx和eax中
    add esi, eax        ; 总内存！！！

    mov edx, esi        ; 
    jmp .mem_get_ok

;--------------------------------------------------------------------
; int 0x15, ah = 0x88, 获取内存大小，只能获取64MB以内
;--------------------------------------------------------------------
.e801_failed_so_try88:
    mov ah, 0x88
    int 0x15
    jc .error_hlt
    and eax, 0x0000FFFF

    mov cx, 0x400
    mul cx          ; ax * cx
    shl edx, 16 
    ;and eax, 0x0000FFFF
    or edx, eax
    add edx, 0x100000   ; 实际内存 + 1MB

.mem_get_ok:
    mov [total_mem_bytes], edx

; 准备进入保护模式
; 1. 打开A20地址线
; 2. 加载GDT
; 3. 将cr0的pe位置1

    ; 1.打开A20地址线
    in al, 0x92
    or al, 0000_0010B
    out 0x92, al 

    ; 加载GDT
    lgdt [gdt_ptr]              ; 

    ; CR0第0位置1
    mov eax, cr0 
    or eax, 0x00000001          ; 
    mov cr0, eax

    ;jmp dword SELECTOR_CODE:p_mode_start ; 代码段的p_mode_start，刷新流水线
    jmp dword SELECTOR_CODE:p_mode_start	     ; 刷新流水线，避免分支预测的影响,这种cpu优化策略，最怕jmp跳转，
					     ; 这将导致之前做的预测失效，从而起到了刷新的作用。
.error_hlt:
    hlt                     ; 出错，挂起


[bits 32]
p_mode_start: 
    mov ax, SELECTOR_DATA
    mov ds, ax 
    mov es, ax 
    mov ss, ax 
    mov esp, LOADER_STACK_TOP
    mov ax, SELECTOR_VIDEO
    mov gs, ax                  ; gs，显示内存？

    mov byte [gs:160], 'P'      ; 80*25，每行80个字符，一个字符2字节，故第二行偏移为160

    jmp $