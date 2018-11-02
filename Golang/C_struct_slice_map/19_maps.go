package main

import (
	"fmt"
)

type Vertex struct {
	Lat, Long float64
}

var m map[string]Vertex

func main() {
	m = make(map[string]Vertex)
	m["isshe"] = Vertex{
		40.64433, -74.39967,
	}
	fmt.Println(m, m["isshe"])
}
