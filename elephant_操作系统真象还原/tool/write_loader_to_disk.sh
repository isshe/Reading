#!/bin/sh

if [ ! $1 ]
then
    echo "请指定loader.bin文件!"
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

dd if=$target_bin of=$disk_path bs=512 count=3 seek=2 conv=notrunc
