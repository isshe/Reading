package main

import (
	"fmt"
)

func main() {
	i := 42
	f := 42.0
	b := 42.0 + 0.1i

	fmt.Printf("type(i) = %T\n", i)
	fmt.Printf("type(f) = %T\n", f)
	fmt.Printf("type(b) = %T\n", b)
}
