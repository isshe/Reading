
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

