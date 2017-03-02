#include<stdlib.h>
#include<stdio.h>


__global__ void add(int *a, int *b, int *c) {
	c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}



void cython_add(int *a, int *b, int *result, int N) {
	int size = N*sizeof(int);
	int *d_a, *d_b, *d_result;
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_result, size);
	// Copy array a to d_a, b to d_b on the device.
	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
	cudaMalloc((void **) &d_a, size);
	cudaMalloc((void **) &d_b, size);
	cudaMalloc((void **) &d_result, size);
	add<<<N,1>>>(d_a, d_b, d_result);
	cudaMemcpy(result, d_result, size, cudaMemcpyDeviceToHost);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_result);

}