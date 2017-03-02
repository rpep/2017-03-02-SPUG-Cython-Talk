#include "gravkernel.cu"
#include <grav.hh>
using namespace std;

void F(double *f, double *r, double *q, int N) {
    double *d_f, *d_r, *d_q;
    int size = sizeof(double) * N;
    cudaMalloc((void **) &d_f, size);
    cudaMalloc((void **) &d_r, size);
    cudaMalloc((void **) &d_q, size);
    cudaMemcpy(d_r, r, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_q, q, size, cudaMemcpyHostToDevice);
    fcuda<<<N,1>>>(d_f, d_r, d_q, N);
    cudaMemcpy(f, d_f, size, cudaMemcpyDeviceToHost);
    cudaFree(d_r);
    cudaFree(d_q);
    cudaFree(d_f);
}
