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


;回车：
; 当为backspace字符时，本质上只要将光标移向前一个显存位置即可，后面输入的字符自然会覆盖此处的字符。
; 但有可能键入backspace后不再需要输入自身，这时光标向前移，但是字符没有被删除，因此此处需添加空格或空字符0
.is_backspace:
    dec bx                  ; bx是光标位置
    shl bx, 1               ; *2, 表示光标对应显存中的偏移字节
    mov byte [gs:bx], 0x20  ; 将待删除的字节补为0或空格即可
    inc bx                  ; 指向下一个位置
    mov byte [gs:bx], 0x07  ; 字符属性！！！？？？
    shr bx, 1               ; /2
    jmp .set_cursor

.put_other:
    shl, bx, 1              ; *2
    mov [gs:bx], cl         ; 字符本身
    inc bx
    mov byte [gs:bx], 0x07   ; 字符属性
    shr bx, 1
    inc bx
    cmp bx, 2000            ; ???
    jl .set_cursor          ; 若光标值小于2000，表示未写到缓存的最后，则设置新的光标值
                            ; 若超出屏幕字符数大小(2000)，则换行处理
.is_line_feed:              ; 换行符LF(\n)
.is_carriage_return:        ; 回车符CR(\r)，光标直接移动行首
    xor dx, dx              ; dx是被除数的高16位
    mov ax, bx              ; ax是被除数的低16位
    mov si, 80              
    div si                  ; \n和\r处理为Linux中的\n，除80，得到行数
    sub bx, dx              ; 减去余数，便是取整

.is_carriage_return_end     ; 回车符CR处理结束 ???
    add bx, 80              ; bx前面已经取整，+80是指向下一行行首
    cmp bx, 2000

is_line_feed_end:           ; 若是LF(\n),将光标移+80即可
    jl .set_cursor          


; 屏幕行范围是0~24，滚屏的原理是将屏幕的第1~24行搬运到0~23行，再将24行清空
; 这种方法相对较挫，以后有机会可以换成用Start Address High Register和Start Address Low Register寄存器的方法。
.roll_screen:
    cld                     ; 指定块传送方向指令。cld：地址从低到高。STD：地址从高到低
    mov ecx, 960            ; 循环960次，24*80 = 1920个字符数，每个字符2个字节，每次搬运4个字节
    mov esi, 0xc00b80a0     ; 第1行行首？？？
    mov edi, 0xc00b8000     ; 第0行行首？？？
    rep movsd

    ; 将最后一行填充为空白
    mov ebx, 3840           ; 1920 * 2: 第24行的起始字符位置
    mov ecx, 80             ; 80次，一次2字节

.cls:
    mov word [gs:ebx], 0x0720       ; 0x0720: 黑底白字的空格符
    add ebx, 2
    loop .cls
    mov bx, 1920                    ; 重置光标为1920，24行行首

.set_cursor:
    ; 将光标设为bx的值
    ; 先设置高8位
    mov dx, 0x03d4                  ; 索引寄存器
    mov al, 0x0e                    ; 指定索引，指定寄存器
    out dx, al                      
    
    mov dx, 0x03d5                  ; 读/写寄存器
    mov al, bh                      
    out dx, al                      ; 设置高8位

    ; 设置低8位
    mov dx, 0x03d4
    mov al, 0x0f
    out dx, al

    mov dx, 0x03d5
    mov al, bl
    out dx, al

.put_char_done:
    popad
    ret
