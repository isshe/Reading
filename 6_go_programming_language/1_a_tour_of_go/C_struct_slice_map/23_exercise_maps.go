package main

func WordCount(s string) map[string]int {
	res := make(map[string]int)

	i := 0
	j := 0
	len := len(s)
	for ; j < len; j++ {
		if s[j] != ' ' {
			continue
		}
		if i < j {
			t := s[i:j]
			res[t] = j - i
			i = j + 1
		}
	}

	if i < j {
		t := s[i:j]
		res[t] = j - i
		i = j + 1
	}
	return res
}

func main() {
	res := WordCount("i am hahaha ")
	for k, v := range res {
		println(k, v)
	}
}
