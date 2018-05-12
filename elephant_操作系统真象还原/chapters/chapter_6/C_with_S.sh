
#!/bin/sh
gcc -o C_with_S_c.o -c C_with_S_c.c -m32
nasm -f elf -o C_with_S_S.o C_with_S_S.S
ld -m elf_i386 -o C_with_S.bin C_with_S_c.o C_with_S_S.o