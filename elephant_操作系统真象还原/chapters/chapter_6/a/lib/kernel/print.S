TI_GDT  equ 0
RPL0    equ 0
SELECTOR_VIDEO  equ (0x0003 << 3) + TI_GDT + RPL0

[bits 32]
section .text

;---------------------------------------------------------------------------------
; put_char: 功能描述：把栈中的1个字符写入光标所在处
;---------------------------------------------------------------------------------
global put_char
put_char:
    pushad                  ; 备份32位寄存器环境
    
    mov ax, SELECTOR_VIDEO  ; 不能直接把立即数送入段寄存器
    mov gs, ax              ; 需保证gs中为正确的视频选择子，保险起见，每次都赋值

    ; 获取当前光标位置
    ; 先获取8位
    mov dx, 0x03d4          ; 索引寄存器 （？？？）
    mov al, 0x0e            ; 用于提供光标位置的高8位（？？？）
    out dx, al
    mov dx, 0x03d5          ; 通过读写数据端口0x3d5获取/设置光标位置
    in al, dx               ; 获取光标位置的高8位（？？？）
    mov ah, al

    ; 将光标存入bx
    mov bx, ax
    mov ecx, [esp + 36]     ; 在栈中获取待打印的字符
                            ; pushad 压入4*8=32字节（？？？）
                            ; 加上主调函数4字节的返回地址故esp+36字节
                            
    ; 处理回车(CR)/换行(LF)/退格(BS)符
    cmp cl, 0xd             ; CR是0x0d，LF是0x0a
    jz .is_carriage_return
    cmp cl, 0xa
    jz .is_line_feed
    cmp c, 0x8              ; BS(backspace)是asc码的8
    jz .is_backspace
    
    jmp .put_other          ; 其他都认为是可见字符！
