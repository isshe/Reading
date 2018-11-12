package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	counts := make(map[string]int)
	input := bufio.NewScanner(os.Stdin)
	// 用ctrl + D结束输入
	for input.Scan() {
		counts[input.Text()]++
	}

	fmt.Println("????")
	for line, n := range counts {
		fmt.Printf("%d\t%s\n", n, line)
	}
}
