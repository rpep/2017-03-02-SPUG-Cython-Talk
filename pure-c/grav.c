#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>
#include "grav.h"

#define _USE_MATH_DEFINES

int main(void) {
    clock_t begin = clock();
    int N = 10000;
    double r[2*N];
    double f[2*N];
    double q[N];
    int i;
    

    for(i = 0; i < N; i++) {
        r[2*i+0] = drand48();
        r[2*i+1] = drand48();
        q[i] = 2*drand48() - 1;
    }

    double t = 0;
    double dt = 0.001;
    double T = 0.1;

    while(t < T) {
        F(f, r, q, N);
        for(i = 0; i < N; i++) {
            r[2*i+0] += f[2*i+0]*dt*dt;
            r[2*i+1] += f[2*i+1]*dt*dt;
            t += dt;
        }
    }

    clock_t end = clock();
    printf("Pure C time: %f", (double)(end - begin) / CLOCKS_PER_SEC);

}