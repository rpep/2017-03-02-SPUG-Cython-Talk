#ifndef __GRAV__H__
#define __GRAV__H__

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<time.h>

#define _USE_MATH_DEFINES

void F(double *f, double *r, double *q, int N) {
    double Fval, theta, dx, dy;
    int i, j;
    for(i = 0; i < N; i++) {
        for(j = 0; j < N; j++) {
            f[2*i + j] = 0;
        }
    }

    #pragma omp parallel for schedule(dynamic, 32) private(j, dx, dy, theta, Fval)
    for(i = 0; i < N; i++) {
        for(j = 0; j < N; j++) {
            if(i != j) {
                dx = r[2*i + 0] - r[2*j+0];
                dy = r[2*i + 1] - r[2*j+1];
                theta = atan2(dy, dx);
                Fval = q[i]*q[j]/(4*M_PI*8.854e-12*(dx*dx + dy*dy));
                f[2*i+0] += Fval*cos(theta);
                f[2*i+1] += Fval*sin(theta);
            }
        }
    }
}

#endif