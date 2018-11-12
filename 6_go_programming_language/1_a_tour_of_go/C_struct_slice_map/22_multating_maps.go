package main

import (
	"fmt"
)

func main() {
	m := make(map[string]int)

	m["isshe"] = 12
	println(m["isshe"])

	m["isshe"] = 48
	println(m["isshe"])

	delete(m, "isshe")
	println(m["isshe"])

	v, ok := m["isshe"]
	fmt.Println("The value: ", v, "present?", ok)

}
