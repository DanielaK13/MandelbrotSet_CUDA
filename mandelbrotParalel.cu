//==============================================
//TRABALHO DE PROGRAMAÇÃO PARALELA E DISTRIBUÍDA
//		         Mandelbrot Set
//	                 CUDA
//          Daniela Kuinchtner, 152064
//==============================================

#include <iostream>
#include <cstdlib>

using namespace std;

#define THREADSPERBLOCK 1024


__global__ void brot(char *d_A, int max_row, int max_column, int max_n, int n);


int main(int argc, char *argv[]){

	int max_row, max_column, max_n;

	max_row = atoi(argv[1]);
	max_column = atoi(argv[2]);
	max_n = atoi(argv[3]);

	int n = max_row * max_column;
	size_t size = n * sizeof(char);

	int nBlocks = (n+THREADSPERBLOCK-1) / THREADSPERBLOCK; 

	char *h_A; 
    char *d_A; 

    h_A = (char *)malloc(size);

    cudaSetDevice(0); 

    cudaMalloc((void**)&d_A, size); 

    cudaMemcpy(d_A, h_A, size ,cudaMemcpyHostToDevice);

    brot <<< nBlocks, THREADSPERBLOCK >>> (d_A, max_row, max_column, max_n, n);
	
    cudaMemcpy(h_A, d_A, size, cudaMemcpyDeviceToHost); 
    
    int i = 0;
    for(int r = 0; r < max_row; ++r){
		for(int c = 0; c < max_column; ++c){

			cout << h_A[i++]; 
		}
		cout << "\n"; 
	}

    cudaFree(d_A);
}


__global__ void brot(char *d_A, int max_row, int max_column, int max_n, int n){
        
	int k = 0;
	int i = blockIdx.x * blockDim.x + threadIdx.x; 

    if(i < n){ 
    	int r = i / max_column;
    	int c =  i % max_column;

	    float x=0, y=0, tmp=0;
	    while((x*x + y*y) < 4 && ++k < max_n) {
	                tmp = x*x - y*y + ((float) c * 2 / max_column - 1.5);
	                y = x*y*2 + ((float) r * 2 / max_row - 1);
	                x = tmp;
	    }
	    d_A[i]=(k == max_n ? '#' : '.');		
    }
}