package main

import (
	"fmt"
	"sync"
	"time"
)

type SafeMaper struct {
	v map[string]bool
	mux sync.Mutex
}

func (m *SafeMaper)isExist(key string) bool{
	var res bool
	m.mux.Lock()
	if m.v[key] {
		res = true
	} else {
		res = false
	}
	m.v[key] = true
	m.mux.Unlock()
	return res
}

var maper = SafeMaper{v:make(map[string]bool)}

type Fetcher interface {
	Fetch(url string) (body string, urls []string, err error)
}

func Crawl(url string, depth int, fetcher Fetcher) {	
	if depth <= 0 {
		return
	}

	if maper.isExist(url) {
		return
	}

	body, urls, err := fetcher.Fetch(url)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("found: %s %q\n", url, body)
	for _, u := range urls {
		go Crawl(u, depth - 1, fetcher)
	}
	return
}

func main() {
	go Crawl("https://golang.org/", 4, fetcher)
	time.Sleep(time.Second)
}

type fakeFetcher map[string]*fakeResult

type fakeResult struct {
	body string
	urls []string
}

func (f fakeFetcher)Fetch(url string)(string, []string, error) {
	if res, ok := f[url]; ok {
		return res.body, res.urls, nil
	}
	return "", nil, fmt.Errorf("not found: %s", url)
}

// fetcher 是填充后的 fakeFetcher。
var fetcher = fakeFetcher{
	"https://golang.org/": &fakeResult{
		"The Go Programming Language",
		[]string{
			"https://golang.org/pkg/",
			"https://golang.org/cmd/",
		},
	},
	"https://golang.org/pkg/": &fakeResult{
		"Packages",
		[]string{
			"https://golang.org/",
			"https://golang.org/cmd/",
			"https://golang.org/pkg/fmt/",
			"https://golang.org/pkg/os/",
		},
	},
	"https://golang.org/pkg/fmt/": &fakeResult{
		"Package fmt",
		[]string{
			"https://golang.org/",
			"https://golang.org/pkg/",
		},
	},
	"https://golang.org/pkg/os/": &fakeResult{
		"Package os",
		[]string{
			"https://golang.org/",
			"https://golang.org/pkg/",
		},
	},
}