section .data
str_c_lib: db "c libray says: hello world!", 0xa        ; 0xa 为LF ASCII码
str_c_lib_len   equ $-str_c_lib

str_syscall: db "syscall says: hello world!", 0xa 
str_syscall_len equ $-str_syscall

section .text
global _start
_start:
    ;方式1：模拟C语言中系统调用库函数write
    push str_c_lib_len                  ; 第3个参数
    push str_c_lib                      ; 第2个参数
    push 1                              ; 第1个参数
    call simu_write
    add esp, 12                         ; 回收栈空间

    ;方式2：跨过库函数，直接进行系统调用
    mov eax, 4                          ; 4号子功能：write系统调用
    mov ebx, 1                          ; 三个参数
    mov ecx, str_syscall
    mov edx, str_syscall_len
    int 0x80

    ; 退出程序
    mov eax, 1                          ; 1号子功能：exit系统调用
    int 0x80

simu_write:
    push ebp                            ; 备份ebp
    mov ebp, esp
    mov eax, 4                          ; 4号子功能：write系统调用
    mov ebx, [ebp + 8]                  ; 这里的栈地址不是很懂！！！？？？
    mov ecx, [ebp + 12]
    mov edx, [ebp + 16]
    int 0x80
    pop ebp
    ret