package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("When's Saturday?")

	today := time.Now().Weekday()

	fmt.Println("today = ", today);
	fmt.Println("today + 1 = ", today + 1);
	fmt.Println("time.Saturday = ", time.Saturday);
	switch time.Saturday {
	case today + 0:
		fmt.Println("Today")
	case today + 1:
		fmt.Println("tomorrow")
	case today + 2:
		fmt.Println("In two days")
	default:
		fmt.Println("Too far away")
	}
}