package main

import (
	"fmt"
)

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"isshe":  {40.111111, -74.11123},
	"google": {50.222222, -47.223232},
}

func main() {
	fmt.Println(m)
}
