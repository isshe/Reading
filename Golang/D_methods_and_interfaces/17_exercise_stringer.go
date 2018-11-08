package main

import (
	"fmt"
)

type IPAdder [4]byte

func (ip IPAdder) String() string {
	var str string

	for i := 0; i < 3; i++ {
		str += ip[i] + "."
	}
	/*
		for p := range ip {
			str += string(p) + "."
		}
	*/
	str += "."

	//fmt.Println(str)
	return str
}

func main() {
	hosts := map[string]IPAdder{
		"lookback":  {127, 0, 0, 1},
		"googleDNS": {8, 8, 8, 8},
	}

	for name, ip := range hosts {
		fmt.Printf("%v: %v\n", name, ip)
	}
}
