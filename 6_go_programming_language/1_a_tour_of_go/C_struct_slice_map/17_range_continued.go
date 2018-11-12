package main

import (
	"fmt"
)

func main() {
	pow := make([]int, 10)

	// 这里cap(pow)为什么是101 ？？？
	fmt.Printf("len(pow)=%d cap(pow)=%d", len(pow), cap(pow))

	for i := range pow {
		pow[i] = 1 << uint(i) // == 2 ** i
	}

	for _, value := range pow {
		fmt.Printf("%d\n", value)
	}
}
