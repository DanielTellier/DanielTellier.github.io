# Blog 3: CUDA Basics

## Objective
Introduce important CUDA basic concepts.

## Table of Contents
- [Kernel Call](#kernel-call)

## Kernel Call
```cpp
kernel<<<N, 1>>>(...);
```
Above is a kernel call where N blocks will run in parallel each with \
a single thread.

```cpp
kernel<<<1, N>>>(...);
```
Above N threads will run in parallel within a single block.

For accessing kernel specific dims and indicies the following are available:
- Note: 3 dimensions available x, y, and z. Below will focus only on x.
- gridDim.x -> number of blocks along x dim of the grid
- blockDim.x -> number of threads along x dim of each block
- blockIdx.x -> Index of specific block in a grid along x dim
- threadIdx.x -> Index of specific thread in a block along x dim
- To convert from 2D to linear space along x use:
    - tidx = threadIdx.x + blockIdx.x * blockDim.x

Grid/Block/Thread example: \
\++++++++++++++++++ \
\+~~~~++~~~~++~~~~+ \
\+~~~~++~~~~++~~~~+ \
\+~~~~++~~~~++~~~~+ \
\+~~~~++~~~~++~~~~+ \
\++++++++++++++++++

The above example would have:
- gridDim.x = 3 blocks
- blockDim.x = 4 threads
- blockDim.y = 4 threads
- kernel<<<3,(4,4)>>>(...);

## References
- Professional CUDA C Programming by John Cheng, Max Grossman, Ty McKercher
- Programming Massively Parallel Processors by David Kirk, Wen-mei Hwu
