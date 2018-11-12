TI_GDT equ  0
RPL0  equ   0
SELECTOR_VIDEO equ (0x0003<<3) + TI_GDT + RPL0

[bits 32]
section .text


;-------------------------------------------------------
; put_str: 通过put_char来打印以0结尾的字符串
; 输入：栈中参数为打印的字符串的地址
; 输出：无
;-------------------------------------------------------
global put_str
put_str:
    push ebx
    push ecx                ; 用多少，备份多少

    xor ecx, ecx
    mov ebx, [esp + 12]     ; 从栈中得到待打印的字符串地址

.goon:
    mov cl, [ebx]           ; ebx地址中的字符赋值给cl
    cmp cl, 0               ; 是否为0，0表示字符串结束
    jz .str_over
    push ecx                ; 为put_char传递参数
    call put_char
    add esp, 4              ; 回收栈空间
    inc ebx                 ; 指向下一个字符
    jmp .goon

.str_over:
    pop ecx
    pop ebx
    ret

;-------------------------------------------------------------
; put_str: 将小端字节序的数字变成相应的ASCII后，倒置，用put_char输出
; 输入：栈中参数为打印的数字
; 输出：16进制数字（没有0x前缀），例如十进制15，打印为f
;-------------------------------------------------------------
put_int_buffer dq 0

global put_int
put_int:
    pushad                  ; 备份所有
    mov ebp, esp            ; ebp栈
    mov eax, [ebp + 4 * 9]  ; 跳过8个寄存器和1个call返回地址，得到传进来的参数
;    mov edx, eax
    mov edi, 7              ; 指定在put_int_buffer中初始的偏移量？？？
    mov ecx, 8              ; 32 / 4 = 8, 4位2进制表示1位16进制数字
    mov ebx, put_int_buffer

; 将32位数字按照16进制的形式从低位到高位处理
; 共处理8个16进制数字
.16based_4bits:             ; 4位2进制表示1位16进制数字
    mov edx, eax            ; ---isshe----
    and edx, 0x0000000f     ; 解析16进制数字的每一位,and后，edx只有4位有效
    cmp edx, 9              ; 0~9，A~F分别处理
    jg .is_A2F              ; A~F
    add edx, '0'            ; 数字0~9, ASCII码是8位大小，add求和操作后，edx低8位有效
    jmp .store

.is_A2F:
    sub edx, 10             ; A~F减10所得的差，加上字符‘A’的ASCII码，便是A～F对应的ASCII码。加‘a’就是‘a～f’
    add edx, 'A'

; 将每位数字转换成对应的字符后，按照类似‘大端’的顺序，存储到put_int_buffer缓冲区
; 高位字符放在低地址，低位字符刚在高地址
.store:
    mov [ebx + edi], dl     ; edx, mov [put_int_buffer + edi], dl
    dec edi
    shr eax, 4              ; 右移，把已经处理过的4位去掉
    ;mov edx, eax
    loop .16based_4bits

; 现在put_int_buffer中已经全是字符，打印之前把高位连续的‘0’字符去掉，比如00000123->123
.ready_to_print:
    inc edi                 ; 此时edi总共减了8，变为-1(0xffffffff)，加上1使其变为0

.skip_prefix_0:
    cmp edi, 8              ; 若已经比较第9个字符了，则表示待打印的字符串为0
    je .full0               

; 找出连续的0字符，edi作为非0位的最高位字符的偏移
.go_on_skip:
    mov cl, [put_int_buffer + edi]
    inc edi
    cmp cl, '0'
    je .skip_prefix_0       ; 判断下一个字符
    dec edi                 ; 指向了下一个字符，但是当前字符是不‘0’字符，需打印
    jmp .put_each_num

.full0:
    mov cl, '0'             ; 全都是0，就只打印一个0

.put_each_num:
    push ecx                ; cl中为需打印的字符
    call put_char
    add esp, 4              ; 回收栈空间 ！！！老忘记！！！
    inc edi                 ; 指向下一个字符
    mov cl, [put_int_buffer + edi]  
    cmp edi, 8
    jl .put_each_num        ; 只有的都要打印
    popad
    ret

;---------------------------------------------------------------------------------
; put_char: 功能描述：把栈中的1个字符写入光标所在处
;---------------------------------------------------------------------------------
global put_char
put_char:
    pushad                  ; 备份32位寄存器环境
    
    mov ax, SELECTOR_VIDEO  ; 不能直接把立即数送入段寄存器
    mov gs, ax              ; 需保证gs中为正确的视频选择子，保险起见，每次都赋值

    ; 获取当前光标位置
    ; 先获取高8位
    mov dx, 0x03d4          ; 索引寄存器 （？？？）
    mov al, 0x0e            ; 用于提供光标位置的高8位（？？？）
    out dx, al
    mov dx, 0x03d5          ; 通过读写数据端口0x3d5获取/设置光标位置
    in al, dx               ; 获取光标位置的高8位（？？？）
    mov ah, al

    ;再获取低8位
    mov dx, 0x03d4
    mov al, 0x0f
    out dx, al
    mov dx, 0x03d5 
    in al, dx

    ; 将光标存入bx
    mov bx, ax
    mov ecx, [esp+36]     ; 在栈中获取待打印的字符
                            ; pushad 压入4*8=32字节（？？？）
                            ; 加上主调函数4字节的返回地址故esp+36字节
                            
    ; 处理回车(CR)/换行(LF)/退格(BS)符
    cmp cl, 0xd             ; CR是0x0d，LF是0x0a
    jz .is_carriage_return
    cmp cl, 0xa
    jz .is_line_feed
    cmp cl, 0x8              ; BS(backspace)是asc码的8
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
    shl bx, 1              ; *2
    mov [gs:bx], cl         ; 字符本身
    inc bx
    mov byte [gs:bx], 0x07   ; 字符属性
    shr bx, 1
    inc bx
    cmp bx, 2000            ; ???
    ;jl .set_cursor          ; 若光标值小于2000，表示未写到缓存的最后，则设置新的光标值
                            ; 若超出屏幕字符数大小(2000)，则换行处理
.is_line_feed:              ; 换行符LF(\n)
.is_carriage_return:        ; 回车符CR(\r)，光标直接移动行首
    xor dx, dx              ; dx是被除数的高16位
    mov ax, bx              ; ax是被除数的低16位
    mov si, 80              
    div si                  ; \n和\r处理为Linux中的\n，除80，得到行数
    sub bx, dx              ; 减去余数，便是取整

.is_carriage_return_end:     ; 回车符CR处理结束 ???
    add bx, 80              ; bx前面已经取整，+80是指向下一行行首
    cmp bx, 2000

.is_line_feed_end:           ; 若是LF(\n),将光标移+80即可
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
