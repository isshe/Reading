    ;创建页目录及页表并初始化也内存位图
    call setup_page

    ;要将描述符表地址及偏移量写入内存gdt_ptr，之后用新的地址(虚拟地址)重新加载
    sgdt [gdt_ptr]                          ; 将sgdt里面的内存存到[gdt_ptr]中

    ;将gdt描述符中视频段描述符中的段基址+0xc0000000 (0xc00 MB)
    ;视频段是第3个段描述符，每个描述符8字节，故0x18（24）
    ;段描述符的高4字节的最高位是段基址的第31~24位
    mov ebx, [gdt_ptr + 2]                  ; ???
    or dword [ebx + 0x18 + 4], 0xc0000000   ; ???
    add dword [gdt_ptr + 2], 0xc0000000     ; gdt的基址+0xc0000000使其成为内核所在的高地址

    add esp, 0xc0000000                     ; 将栈指针映射到内核地址（？？？那栈如何生长？小于0xc0000000的不是没映射？）

    ; 将页目录地址赋值给cr3，cr3是页目录基址寄存器(PDBR)
    mov eax, PAGE_DIR_TABLE_POS
    mov cr3, eax

    ;打开cr0的pg位（31位）=>paging，开启分页
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    ;开启分页后，用gdt新地址重新加载gdt
    lgdt [gdt_ptr]

    moiv byte [gs:160], "V"                 ; 视频段基址已经更新，V表示virtual
    jmp $


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
    mov [PAGE_DIR_TABLE_POS + 0x0], eax         ; 第0项
    mov [PAGE_DIR_TABLE_POS + 0xc00], eax       ; 0xc00是第768项的偏移，内核页表的第0项

    ;使最后一个目录项指向页目录表自己的地址
    sub eax, 0x1000
    mov [PAGE_DIR_TABLE_POS + 0x1000], eax      ; 第1024项，1024 × 4 = 4096 = 0x1000

;下面创建页表项(PTE, Page Table Entry)
    mov ecx, 256                                ; 1M低端内存/4K每页 = 256项(只使用低端的1M内存，所以只有256项)
    mov esi, 0
    mov edx, PG_US_U | PG_RW_W | PG_P           ; 这里edx=？？？
.create_pte:
    mov [ebx+esi*4], edx
    add edx, 4096                               ; = 0x1000, = 4K
    inc esi
    loop .create_pte

;创建内核其他页表的页目录项(PDE)，这一部分属于未雨绸缪
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

