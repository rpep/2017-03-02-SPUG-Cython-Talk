#include <stdio.h>
#include <math.h>

void __global__ fcuda(double *f, double *r, double *q, int N) {
    int i = blockIdx.x;
    double xi = r[2*i + 0];
    double yi = r[2*i + 1];
    double dx, dy, Fval, theta;
    f[i] = 0;
    for(int j = 0; j < N; j++) {
	if (i != j) {
        dx = xi - r[2*j+0];
        dy = yi - r[2*j+1];
        theta = atan2(dy, dx);
        Fval = q[i]*q[j]/(4*M_PI*8.854e-12*(dx*dx + dy*dy));
        f[2*i+0] += Fval*cos(theta);
        f[2*i+1] += Fval*sin(theta);
       }
   }
}

