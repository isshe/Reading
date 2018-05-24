#!/bin/sh

install_path="/opt/bochs-2.6.9/"
if [ $1 ]
then
    install_path=$1
fi

sudo apt-get install nasm
sudo apt-get install build-essential xorg-dev libgtk2.0-dev

./configure --prefix=$install_path --enable-debugger --enable-disasm --enable-iodebug --enable-x86-debugger --with-x --with-x11