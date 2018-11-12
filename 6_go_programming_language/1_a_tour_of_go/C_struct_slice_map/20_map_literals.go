package main

import (
	"fmt"
)

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"isshe": Vertex{
		40.44444, -17.00001,
	},
	"chudai": Vertex{
		41.44144, -71.111110,
	},
}

func main() {
	fmt.Println(m)
}
