package main

import "fmt"

type S struct {
	a, b, c int64
	d, e, f string
	g, h, i float64
	j       [1008192]int64
}

func byCopy() S {
	return S{
		a: 1, b: 1, c: 1,
		e: "foo", f: "foo",
		g: 1.0, h: 1.0, i: 1.0,
	}
}

func byPointer() *S {
	return &S{
		a: 1, b: 1, c: 1,
		e: "foo", f: "foo",
		g: 1.0, h: 1.0, i: 1.0,
	}
}

func byCopyArg(s S) {
	s.a = 1
	s.j[89] = 10
	s.j[99] = 10
	_ = fmt.Sprintf("%v", s.a)
}

func byCopyArgReturns(s S) S {
	s.a = 1
	s.j[899] = 10
	_ = fmt.Sprintf("%v", s.a)
	return s
}

func byPointerArg(s *S) {
	s.a = 1
	_ = fmt.Sprintf("%v", s.a)
}
