package main

import (
	"flag"
	"fmt"
	"strings"
)

// go run 2.3.echo4.go a b c
// go run 2.3.echo4.go -s / a b c

// 名字-默认值-描述信息
var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "separator")

func main() {
	// 分析命令行参数
	flag.Parse()
	fmt.Println(strings.Join(flag.Args(), *sep))
	if !*n {
		fmt.Println("...!*n...")
	}
}
