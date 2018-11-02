package main

import "code.google.com/p/go-tour/pic"

func Pic(dx, dy int) [][]int8 {

	res := make([][]uint8, dy)
	for i := range a {
		temp := make([]uint8, dx)
		for j := range temp {
			temp[j] = uint8(x*y - 1)
		}
		res[i] = temp
	}
	return res
}

func main() {
	pic.Show(Pic)
}
