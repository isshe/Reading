package popcount

var pc [256]byte

func init() {
	for i := range pc {
		// 0-255各个树含1的个数
		pc[i] = pc[i/2] + byte(i&1)
	}
}

func PopCount(x uint64) int {
	return int(pc[byte(x>>(0*8))] +
		pc[byte(x>>(1*8))] +
		pc[byte(x>>(2*8))] +
		pc[byte(x>>(3*8))] +
		pc[byte(x>>(4*8))] +
		pc[byte(x>>(5*8))] +
		pc[byte(x>>(6*8))] +
		pc[byte(x>>(7*8))])
}

func PopCount1(x uint64) int {
	var res byte
	var i uint
	for i = 0; i < 8; i++ {
		res += pc[byte(x>>(i*8))]
	}

	return int(res)
}

func PopCount2(x uint64) int {
	var res int = 0
	var i uint
	for i = 0; i < 64; i++ {
		res += int((x >> i) & 1)
	}

	return res
}

func PopCount3(x uint64) int {
	var res int

	for ; x != 0; x = x & (x - 1) {
		res++
	}

	return res
}
