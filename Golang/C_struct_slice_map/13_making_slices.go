package main

import (
	"fmt"
)

func printSlice(s string, x []int) {
	fmt.Printf("%s len=%d cap=%d %v\n", s, len(x), cap(x), x)
}
func main() {
	a := make([]int, 5)
	printSlice("a", a)

	b := make([]int, 0, 5)
	printSlice("b", b)

	// 这里容量5，因为b总容量5，从0开始
	c := b[0:2]
	printSlice("c", c)

	// 这里容量3，因为b总容量5，从2开始
	d := c[2:5]
	printSlice("d", d)
}
