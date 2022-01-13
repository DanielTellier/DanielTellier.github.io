# Blog 3: CUDA Basics

## Objective
Introduce important CUDA basic concepts.

## Table of Contents
- [Kernel Call](#kernel-call)
- [Grid Example](#grid-example)
- [Bandwidth vs Throughput vs Latency](#bandwidth-vs-throughput-vs-latency)
- [CPU vs GPU](#cpu-vs-gpu)
- [GPU Layout](#gpu-layout)
- [GPU Memory Layout](#gpu-memory-layout)
- [References](#references)

## Kernel Call
```cpp
kernel<<<N, 1>>>(...);
```
N blocks will run in parallel each with a single thread.

```cpp
kernel<<<1, N>>>(...);
```
N threads will run in parallel within a single block.

For accessing kernel specific dims and indicies the following are available:
- Note: 3 dimensions available x, y, and z. Below will focus only on x.
- gridDim.x -> number of blocks along x dim of the grid
- blockDim.x -> number of threads along x dim of each block
- blockIdx.x -> Index of specific block in a grid along x dim
- threadIdx.x -> Index of specific thread in a block along x dim
- To convert from 2D to linear space along x use:
    - tidx = threadIdx.x + blockIdx.x * blockDim.x

## Grid Example

<div>
<table>
<tr><td>~~~<br>~~~<br>~~~</td><td>~~~<br>~~~<br>~~~</td></tr>
</table>
</div>

The above example would have:
- gridDim.x = 2 blocks
- blockDim.x = 3 threads
- blockDim.y = 3 threads
- `kernel<<<2,(3,3)>>>(...);`

## Bandwidth vs Throughput vs Latency
- Bandwidth -> highest possible data transfer per time unit
- Throughput -> rate of any kind of info or operations carried out per \
time unit, ergo how many instructions completed per cycle
- Latency -> time for an operation to complete
- Pipe Analogy:
    - Bandwidth = how much can travel through the pipe at once
    - Latency = how long things take to travel through the length of the pipe

## CPU vs GPU
- CPU designed to minimize latency for a single thread which leads to fitting \
a few cores per CPU chip.
- GPU designed to maximize total execution throughput by running a large \
number of threads which leads to fitting thousands of less powerful cores \
per GPU chip.
- If Application has sections of high parallelization then a GPU can achieve \
high bandwidth to make up for each core's longer latency.

## GPU Layout
- GPUs are a collection of Streaming Multiprocessors (SM).
- The SM varies between GPUs ergo why you will see sm\_xx as gencode option \
to nvcc compiler.
- SM partitions blocks assigned to it into 32 threads called warps and \
schedules available warps for execution. All threads in a warp execute \
same instruction.
- Each SM varies in amount of allowable warps to be active at once.
- GPU hides latency by having an SM schedule a different warp when \
one becomes inactive due to waiting for resources. No overhead occured by \
switching warps since already stored on specific SM.
- Threads within warps have own instruction address counter, register state, \
and carry out instructions on own data.

## GPU Memory Layout
- Global Memory -> DRAM on GPU
- Shared Memory -> on-chip GPU memory
- Local Memory -> can be in DRAM or on-chip
- Global Memory has the longest latency in terms of access.
- Shared Memory is alloted to each SM and a copy is created for each block \
launched, thus every thread in a block shares this memory which requires \
kernel synchronization.

## References
- Professional CUDA C Programming by John Cheng, Max Grossman, Ty McKercher
- Programming Massively Parallel Processors by David Kirk, Wen-mei Hwu
