package main

import (
	"fmt"
	"isshe/popcount"
)

func main() {
	fmt.Println(popcount.PopCount(8))
	fmt.Println(popcount.PopCount1(8))
	fmt.Println(popcount.PopCount2(8))
	fmt.Println(popcount.PopCount3(8))
}
