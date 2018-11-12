package main

import (
	"fmt"
	"strings"
)

func main() {
	// create a tic-tac-toe board
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}

	// the players take turns
	board[0][0] = "Xxxx"
	board[2][2] = "Oooo"
	board[1][2] = "X"
	board[1][0] = "O"
	board[0][2] = "X"

	fmt.Println("len(board) = ", len(board))
	for i := 0; i < len(board); i++ {
		fmt.Println("%s\n", strings.Join(board[i], ", "))
	}
}
