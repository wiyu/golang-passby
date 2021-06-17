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
