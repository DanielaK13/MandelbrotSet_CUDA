# MandelbrotSet_CUDA

The Mandelbrot set is a set of complex numbers. [This code](mandelbrotParalel.cu) parallelizes the mandelbrot using CUDA.

<img src="figures/example.PNG" width="500">

## Getting started

- Download this project;
- [Read the report](TechnicalReport_MandelbrotSetCUDA.pdf) (written in brazilian portuguese).

## Running

```
nvcc mandelbrotCuda.cu
./a.out 1024 768 18000

```

## Results

I used a Intel® Core™ i7-2600 CPU @ 3.40GHz × 8, 4 physical cores and 4 logical cores, 8 GB of RAM and Ubuntu 16.04 LTS 64-bit operating system to run the tests. And a Geforce GT 630 GPU, which has 2 multiprocessors with 1536 threads each, 1GB of memory, maximum 1024 threads per block and 3072 threads for the entire device.

#### Input: 
- 1024 rows;
- 768 columns;
- 18000 iterations.

| # | Sequential | Paralel |
| --- | --- | --- | 
| 1 | 0m46.255s | 0m2.308s |
| 2 | 0m45.585s | 0m2.121s |
| 3 | 0m44.916s | 0m2.134s |
| 4 | 0m46.453s | 0m2.103s |
| 5 | 0m45.018s | 0m2.094s |
| 6 | 0m44.988s | 0m2.056s |
| 7 | 0m45.256s | 0m2.204s |
| 8 | 0m45.871s | 0m2.301s |
| 9 | 0m45.479s | 0m2.129s |
| 10 | 0m46.112s | 0m2.114s |

#### This was an assignment for Parallel and Distributed Programming class by Ph.D Marcelo Trindade Rebonatto from University of Passo Fundo.

