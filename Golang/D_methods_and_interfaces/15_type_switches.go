package main

import (
	"fmt"
)

type I interface{}

func do(i I) {
	// 这个type只能在switch中用
	switch v := i.(type) {
	case int:
		fmt.Printf("int: Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("string: %q is %v byptes long\n", v, len(v))
	default:
		fmt.Printf("default: I don't know about type %T\n", v)
	}
}

func main() {
	do(21)
	do("hello")
	do(true)
}
