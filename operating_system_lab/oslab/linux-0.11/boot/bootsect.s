!
! SYS_SIZE is the number of clicks (16 bytes) to be loaded.
! 0x3000 is 0x30000 bytes = 196kB, more than enough for current
! versions of linux
!
SYSSIZE = 0x3000
!
!	bootsect.s		(C) 1991 Linus Torvalds
!
! bootsect.s is loaded at 0x7c00 by the bios-startup routines, and moves
! iself out of the way to address 0x90000, and jumps there.
! bootsect.s 被ROM BIOS启动子程序加载至0x7c00 (31KB)处，并将自己移到了地址0x90000(576KB)处，并跳转至那里。
! 为什么它会被ROM BIOS加载？它如何被BIOS自动加载？是BIOS自动到磁盘的某处读取吗？

! It then loads 'setup' directly after itself (0x90200), and the system
! at 0x10000, using BIOS interrupts. 
! 它然后使用BIOS中断将'setup'直接加载到自己的后面(0x90200)(576.5KB)，并将system加载到地址0x10000处。

! NOTE! currently system is at most 8*65536 bytes long. This should be no
! problem, even in the future. I want to keep it simple. This 512 kB
! kernel size should be enough, especially as this doesn't contain the
! buffer cache as in minix
! 注意! 目前的内核系统最大长度限制为(8*65536)(512KB)字节，即使是在将来这也应该没有问题的。
! 我想让它保持简单明了。这样512KB的最大内核长度应该足够了，尤其是这里没有像MINIX中一样包含缓冲区高速缓冲。

! The loader has been made as simple as possible, and continuos
! read errors will result in a unbreakable loop. Reboot by hand. It
! loads pretty fast by getting whole sectors at a time whenever possible.
! 加载程序已经做得够简单了，所以持续地读操作出错将导致死循环。只能手工重启。
! 只要可能，通过一次读取所有的扇区，加载过程可以做得很快。

! 伪指令（伪操作符）.globl或.global用于定义随后的标识符是外部的或全局的，并且即使不使用也强制引入。 
! .text、.data和.bss用于分别定义当前代码段、数据段和未初始化数据段。
! 在链接多个目标模块时，链接程序（ld86）会根据它们的类别把各个目标模块中的相应段分别
! 组合（合并）在一起。这里把三个段都定义在同一重叠地址范围中，因此本程序实际上不分段。
! 另外，后面带冒号的字符串是标号，例如下面的'begtext:'。
! 一条汇编语句通常由标号（可选）、指令助记符（指令名）和操作数三个字段组成。标号位于
! 一条指令的第一个字段。它代表其所在位置的地址，通常指明一个跳转指令的目标位置。

.globl begtext, begdata, begbss, endtext, enddata, endbss
.text
begtext:
.data
begdata:
.bss
begbss:
.text

SETUPLEN = 4				! nr of setup-sectors 					setup程序代码占用磁盘扇区数(setup-sectors)值；
BOOTSEG  = 0x07c0			! original address of boot-sector		引导扇区起始地址， bootsect代码所在内存原始段地址；
INITSEG  = 0x9000			! we move boot here - out of the way	! 将bootsect移到位置0x90000 - 避开系统模块占用处；
SETUPSEG = 0x9020			! setup starts here						! setup程序从内存0x90200处开始；
SYSSEG   = 0x1000			! system loaded at 0x10000 (65536). 	! system模块加载到0x10000（64 KB）处；
ENDSEG   = SYSSEG + SYSSIZE		! where to stop loading

! 根文件系统设备号ROOT_DEV和交换设备号SWAP_DEV 现在由tools目录下的build程序写入。
! 设备号0x306指定根文件系统设备是第2个硬盘的第1个分区。当年Linus是在第2个硬盘上
! 安装了Linux 0.11系统，所以这里ROOT_DEV被设置为0x306。在编译这个内核时你可以根据
! 自己根文件系统所在设备位置修改这个设备号。这个设备号是Linux系统老式的硬盘设备号命
! 名方式，硬盘设备号具体值的含义如下：
! 设备号=主设备号*256 + 次设备号（也即dev_no = (major<<8) + minor ）
! （主设备号：1-内存,2-磁盘,3-硬盘,4-ttyx,5-tty,6-并行口,7-非命名管道）
! ROOT_DEV:	0x000 - same type of floppy as boot.
!		0x301 - first partition on first drive etc 	第一个磁盘的第一个分区
ROOT_DEV = 0x306

! 伪指令entry迫使链接程序在生成的执行程序（a.out）中包含指定的标识符或标号。这里是
! 程序执行开始点。73 -- 82行作用是将自身(bootsect)从目前段位置 0x07c0(31KB) 移动到
! 0x9000(576KB) 处，共256字（512字节），然后跳转到移动后代码的go标号处，也即本程
! 序的下一语句处。
entry _start
_start:
	mov	ax,#BOOTSEG 		! 0x07c0
	mov	ds,ax
	mov	ax,#INITSEG			! 0x9000
	mov	es,ax
	mov	cx,#256 			! 256次，一次一个word，总共512字节，一个扇区
	sub	si,si				! 源地址   ds:si = 0x07C0:0x0000
	sub	di,di				! 目的地址 es:di = 0x9000:0x0000
	rep
	movw					! 即movs指令。从内存[si]处移动cx个字到[di]处。
	jmpi	go,INITSEG		! 跳到0x9000，段间跳转（Jump Intersegment）, 指出跳转到的段地址，标号go是段内偏移地址。

! 这段代码设置几个段寄存器，包括栈寄存器ss和sp。栈指针sp只要指向远大于512字节偏移
! （即地址0x90200）处都可以。因为从0x90200地址开始处还要放置setup程序，而此时setup
! 程序大约为4个扇区，因此sp要指向大于（0x200 + 0x200 * 4 +堆栈大小）位置处。这里sp
! 设置为 0x9ff00 - 12（参数表长度），即sp = 0xfef4。在此之上位置会存放一个自建的驱动
! 器参数表，见下面说明。实际上BIOS把引导扇区加载到0x7c00 处并把执行权交给引导程序时，
! ss = 0x00，sp = 0xfffe。
go:	mov	ax,cs			! 将ds、es和ss都置成移动后代码所在的段处(0x9000)。
	mov	ds,ax
	mov	es,ax
! put stack at 0x9ff00.
	mov	ss,ax
	mov	sp,#0xFF00		! arbitrary value >>512

! 在bootsect程序块后紧根着加载setup模块的代码数据。
! 注意es已经设置好了。（在移动代码时es已经指向目的段地址处0x9000）。
! 110--119行的用途是利用ROM BIOS中断INT 0x13 将setup 模块从磁盘第2个扇区开始读到
! 0x90200 开始处，共读 4个扇区。
！[v0.12]在读操作过程中如果读出错，则显示磁盘上出错扇区位置，然后复位驱动器并重试，没有退路。
! INT 0x13读扇区使用调用参数设置如下：
! ah = 0x02 - 读磁盘扇区到内存；al = 需要读出的扇区数量；
! ch = 磁道(柱面)号的低8位；   cl = 开始扇区(位0-5)，磁道号高2位(位6-7)；
! dh = 磁头号；                 dl = 驱动器号（如果是硬盘则位7要置位）；
! es:bx 指向数据缓冲区；  如果出错则CF标志置位，ah中是出错码。
! load the setup-sectors directly after the bootblock.
! Note that 'es' is already set up.
load_setup:					! 加载setup程序
	mov	dx,#0x0000		! drive 0, head 0
	mov	cx,#0x0002		! sector 2, track 0, 第2扇区0磁道
	mov	bx,#0x0200		! address = 512, in INITSEG
	mov	ax,#0x0200+SETUPLEN	! service 2, nr of sectors
	int	0x13			! read it
	jnc	ok_load_setup	! ok - continue，检查CF标志位，如果为0，说明没有错
	mov	dx,#0x0000
	mov	ax,#0x0000		! reset the diskette
	int	0x13
	j	load_setup 		! 重试！

ok_load_setup:

! Get disk drive parameters, specifically nr of sectors/track

	mov	dl,#0x00
	mov	ax,#0x0800		! AH=8 is get drive parameters
	int	0x13
	mov	ch,#0x00
	seg cs
	mov	sectors,cx
	mov	ax,#INITSEG
	mov	es,ax

! Print some inane message

	mov	ah,#0x03		! read cursor pos
	xor	bh,bh
	int	0x10
	
	mov	cx,#24
	mov	bx,#0x0007		! page 0, attribute 7 (normal)
	mov	bp,#msg1
	mov	ax,#0x1301		! write string, move cursor
	int	0x10

! ok, we've written the message, now
! we want to load the system (at 0x10000)

	mov	ax,#SYSSEG
	mov	es,ax		! segment of 0x010000
	call	read_it
	call	kill_motor

! After that we check which root-device to use. If the device is
! defined (!= 0), nothing is done and the given device is used.
! Otherwise, either /dev/PS0 (2,28) or /dev/at0 (2,8), depending
! on the number of sectors that the BIOS reports currently.

	seg cs
	mov	ax,root_dev
	cmp	ax,#0
	jne	root_defined
	seg cs
	mov	bx,sectors
	mov	ax,#0x0208		! /dev/ps0 - 1.2Mb
	cmp	bx,#15
	je	root_defined
	mov	ax,#0x021c		! /dev/PS0 - 1.44Mb
	cmp	bx,#18
	je	root_defined
undef_root:
	jmp undef_root
root_defined:
	seg cs
	mov	root_dev,ax

! after that (everyting loaded), we jump to
! the setup-routine loaded directly after
! the bootblock:

	jmpi	0,SETUPSEG

! This routine loads the system at address 0x10000, making sure
! no 64kB boundaries are crossed. We try to load it as fast as
! possible, loading whole tracks whenever we can.
!
! in:	es - starting address segment (normally 0x1000)
!
sread:	.word 1+SETUPLEN	! sectors read of current track
head:	.word 0			! current head
track:	.word 0			! current track

read_it:
	mov ax,es
	test ax,#0x0fff
die:	jne die			! es must be at 64kB boundary
	xor bx,bx		! bx is starting address within segment
rp_read:
	mov ax,es
	cmp ax,#ENDSEG		! have we loaded all yet?
	jb ok1_read
	ret
ok1_read:
	seg cs
	mov ax,sectors
	sub ax,sread
	mov cx,ax
	shl cx,#9
	add cx,bx
	jnc ok2_read
	je ok2_read
	xor ax,ax
	sub ax,bx
	shr ax,#9
ok2_read:
	call read_track
	mov cx,ax
	add ax,sread
	seg cs
	cmp ax,sectors
	jne ok3_read
	mov ax,#1
	sub ax,head
	jne ok4_read
	inc track
ok4_read:
	mov head,ax
	xor ax,ax
ok3_read:
	mov sread,ax
	shl cx,#9
	add bx,cx
	jnc rp_read
	mov ax,es
	add ax,#0x1000
	mov es,ax
	xor bx,bx
	jmp rp_read

read_track:
	push ax
	push bx
	push cx
	push dx
	mov dx,track
	mov cx,sread
	inc cx
	mov ch,dl
	mov dx,head
	mov dh,dl
	mov dl,#0
	and dx,#0x0100
	mov ah,#2
	int 0x13
	jc bad_rt
	pop dx
	pop cx
	pop bx
	pop ax
	ret
bad_rt:	mov ax,#0
	mov dx,#0
	int 0x13
	pop dx
	pop cx
	pop bx
	pop ax
	jmp read_track

!/*
! * This procedure turns off the floppy drive motor, so
! * that we enter the kernel in a known state, and
! * don't have to worry about it later.
! */
kill_motor:
	push dx
	mov dx,#0x3f2
	mov al,#0
	outb
	pop dx
	ret

sectors:
	.word 0

msg1:
	.byte 13,10
	.ascii "Loading system ..."
	.byte 13,10,13,10

.org 508
root_dev:
	.word ROOT_DEV
boot_flag:
	.word 0xAA55

.text
endtext:
.data
enddata:
.bss
endbss:
