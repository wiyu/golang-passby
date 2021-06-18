# golang-passby

Testing of pointer vs structs based on this post https://medium.com/a-journey-with-go/go-should-i-use-a-pointer-instead-of-a-copy-of-my-struct-44b43b104963

```
> ./test.sh

Return by value...
name              time/op
MemoryStack-8     5.57ns ± 0%
MemoryStackArg-8  62.1ns ± 0%

name              alloc/op
MemoryStack-8      0.00B     
MemoryStackArg-8   0.00B     

name              allocs/op
MemoryStack-8       0.00     
MemoryStackArg-8    0.00     
-----------------------------------------------------------------------------------------------

Return by pointer...
name             time/op
MemoryHeap-8     47.9ns ± 0%
MemoryHeapArg-8   109ns ± 0%

name             alloc/op
MemoryHeap-8      96.0B ± 0%
MemoryHeapArg-8   96.0B ± 0%

name             allocs/op
MemoryHeap-8       1.00 ± 0%
MemoryHeapArg-8    1.00 ± 0%
-----------------------------------------------------------------------------------------------

Pass struct by value...
name              time/op
MemoryStackArg-8  56.0ns ± 0%

name              alloc/op
MemoryStackArg-8   0.00B     

name              allocs/op
MemoryStackArg-8    0.00     

-----------------------------------------------------------------------------------------------
Pass by pointer...
name             time/op
MemoryHeapArg-8  106ns ± 0%

name             alloc/op
MemoryHeapArg-8  96.0B ± 0%

name             allocs/op
MemoryHeapArg-8   1.00 ± 0%
```

## Escape analysis
From https://segment.com/blog/allocation-efficiency-in-high-performance-go-services/

Build Flags https://golang.org/cmd/compile/
```
$ go build -gcflags="-m -m -l" 
# github.com/DataDog/passby
./passby.go:21:9: &S{...} escapes to heap:
./passby.go:21:9:   flow: {heap} = &{storage for &S{...}}:
./passby.go:21:9:     from &S{...} (too large for stack) at ./passby.go:21:9
./passby.go:21:9: &S{...} escapes to heap
./passby.go:32:25: s.a escapes to heap:
./passby.go:32:25:   flow: {storage for ... argument} = &{storage for s.a}:
./passby.go:32:25:     from s.a (spill) at ./passby.go:32:25
./passby.go:32:25:     from ... argument (slice-literal-element) at ./passby.go:32:17
./passby.go:32:25:   flow: {heap} = {storage for ... argument}:
./passby.go:32:25:     from ... argument (spill) at ./passby.go:32:17
./passby.go:32:25:     from fmt.Sprintf("%v", ... argument...) (call parameter) at ./passby.go:32:17
./passby.go:28:16: s does not escape
./passby.go:32:17: ... argument does not escape
./passby.go:32:25: s.a escapes to heap
./passby.go:38:25: s.a escapes to heap:
./passby.go:38:25:   flow: {storage for ... argument} = &{storage for s.a}:
./passby.go:38:25:     from s.a (spill) at ./passby.go:38:25
./passby.go:38:25:     from ... argument (slice-literal-element) at ./passby.go:38:17
./passby.go:38:25:   flow: {heap} = {storage for ... argument}:
./passby.go:38:25:     from ... argument (spill) at ./passby.go:38:17
./passby.go:38:25:     from fmt.Sprintf("%v", ... argument...) (call parameter) at ./passby.go:38:17
./passby.go:35:23: parameter s leaks to ~r1 with derefs=0:
./passby.go:35:23:   flow: ~r1 = s:
./passby.go:35:23:     from return s (return) at ./passby.go:39:2
./passby.go:35:23: leaking param: s to result ~r1 level=0
./passby.go:38:17: ... argument does not escape
./passby.go:38:25: s.a escapes to heap
./passby.go:44:25: s.a escapes to heap:
./passby.go:44:25:   flow: {storage for ... argument} = &{storage for s.a}:
./passby.go:44:25:     from s.a (spill) at ./passby.go:44:25
./passby.go:44:25:     from ... argument (slice-literal-element) at ./passby.go:44:17
./passby.go:44:25:   flow: {heap} = {storage for ... argument}:
./passby.go:44:25:     from ... argument (spill) at ./passby.go:44:17
./passby.go:44:25:     from fmt.Sprintf("%v", ... argument...) (call parameter) at ./passby.go:44:17
./passby.go:42:19: s does not escape
./passby.go:44:17: ... argument does not escape
./passby.go:44:25: s.a escapes to heap
```