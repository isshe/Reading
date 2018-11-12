#!/bin/sh

# ld -m elf 查看支持的仿真

echo "nasm -f elf -o p258_syscall_write.o p258_syscall_write.S"
nasm -f elf -o p258_syscall_write.o p258_syscall_write.S

echo "ld -m elf_i386 -o p258_syscall_write.bin p258_syscall_write.o"
ld -m elf_i386 -o p258_syscall_write.bin p258_syscall_write.o