#!/bin/sh


nasm -f elf -o lib/kernel/print.o lib/kernel/print.S
gcc -I lib/kernel/ -c -o kernel/main.o kernel/main.c -m32
ld -Ttext 0xc0001500 -e main -o kernel.bin kernel/main.o lib/kernel/print.o -m elf_i386