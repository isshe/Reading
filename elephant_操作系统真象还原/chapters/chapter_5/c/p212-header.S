header:     ;文件头
    program_length  dd program_end - program_start  ; body长度
    start_addr      dd program_start                ; 入口地址


body:       ; 文件体
program_start:
    mov ax, 0x1234
    jmp $
program_end:
