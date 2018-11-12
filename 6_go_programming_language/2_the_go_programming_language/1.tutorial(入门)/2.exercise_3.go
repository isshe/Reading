package main

import (
	"fmt"
	"time"
)

func main() {
	var start = time.Now().UnixNano
	fmt.Println(start)
	var end = time.Now().UnixNano
	fmt.Println(end)
}
