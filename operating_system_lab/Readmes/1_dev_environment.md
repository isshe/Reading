

## 1.1 安装需要的库

```
sudo apt-get install bin86 build-essential libc6-dev-i386
sudo apt-get install libc6-dev-i386 libsm-dev:i386 libxpm-dev:i386 libx11-6:i386 
```



## 1.2 安装gcc-3.4

下载[gcc-3.4-ubuntu.tar.gz]()，解压并进入解压目录：

```
tar zxvf gcc-3.4-ubuntu.tar.gz
cd gcc-3.4
./inst.sh amd64
```

> `amd64`还是`i386`根据自己的系统来，不行就两个都试一下。



## 1.3 编译Kernel 0.11

下载[hit-oslab-linux-20110823.tar.gz]()，解压并进入解压目录：

```
tar zxvf hit-oslab-linux-20110823.tar.gz
cd oslab

make all
../run
```

