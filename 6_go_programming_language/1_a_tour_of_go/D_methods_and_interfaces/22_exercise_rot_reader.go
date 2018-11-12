package main

import (
	"io"
	"os"
	"strings"
)

type rot13Reader struct {
	r io.Reader
}
/*
func (r rot13Reader)Read(b []byte) (int, error) {
	for i, v:= range b {
		if v >= 'A' && v <= 'Z' {
			t := v - 'A' + 13
			b[i] = 'A' + (t % 26)
		}
		
		if v >= 'a' && v <= 'a' {
			t := v - 'a' + 13
			b[i] = 'a' + (t % 26)
		}
	}
	return len(b),nil
}

*/

func rot13(p byte) byte {
	switch {
	case p >= 'A' && p <= 'M': p = p - 'A' + 'N'
	case p >= 'N' && p <= 'Z': p = p - 'N' + 'A'
	case p >= 'a' && p <= 'm': p = p - 'a' + 'n'
	case p >= 'n' && p <= 'z': p = p - 'n' + 'a'
	}
	
	return p
}


func (v rot13Reader)  Read(p []byte) (n int, err error) {
	original := make([]byte, 50)
	i, err := v.r.Read(original)
	for index, value := range original[:i] {
		p[index] = rot13(value)
	}
	return i, err
}

func main() {
	s := strings.NewReader("Lbh penpxrq gur pbqr!")
	r := rot13Reader{s}
	io.Copy(os.Stdout, &r)
}