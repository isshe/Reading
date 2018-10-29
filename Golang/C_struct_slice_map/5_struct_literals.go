package main

import (
	"fmt"
)

type Vertex struct {
	x, y int
}

var (
	v1 = Vertex{1, 2}
	v2 = Vertex{x: 1, y: 3}
	v3 = Vertex{}

	p = &Vertex{1, 2}
)

func main() {
	fmt.Println(v1, p, v2, v3)
	fmt.Println(p.x, p.y)
}
