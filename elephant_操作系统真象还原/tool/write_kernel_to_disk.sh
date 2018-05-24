#!/bin/sh

if [ ! $1 ]
then
    echo "请指定kernel.bin文件!"
    exit 1
fi

target_bin=$1
bochs_dir="/opt/bochs-2.6.9"
disk_path="$bochs_dir/269hd60M.img"

if [ ! -f $disk_path ]
then
    echo "$disk_path文件不存在，请检查！"
    exit 1
fi

#gcc -c -o kernel/main.o  kernel/main.c &&  ld kernel/main.o -Ttext 0xc0001500 -e main -o kernel/kernel.bin && 
dd if=$target_bin of=$disk_path bs=512 count=200 seek=9 conv=notrunc 

