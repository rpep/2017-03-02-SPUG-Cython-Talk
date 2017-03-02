import matplotlib.pyplot as plt
import numpy as np
import time
from cython.parallel import prange
cimport numpy as np
cimport cython

begin = time.time()

cdef F(np.ndarray[double, ndim=2] f,
       np.ndarray[double, ndim=2] r,
       np.ndarray[double, ndim=1] q):
    cdef int i, j
    cdef double dx, dy, F, theta
    cdef int N
    N = len(f)
    f[:] = 0
    for i in range(N):
        for j in range(N):
            if i != j:
                dx = r[i, 0] - r[j, 0]
                dy = r[i, 1] - r[j, 1]
                theta = np.arctan2(dy, dx)
                F = q[i]*q[j]/(4*np.pi*8.854e-12*(dx*dx + dy*dy))
                f[i, 0] += F*np.cos(theta)
                f[i, 1] += F*np.sin(theta)

N = 1000
np.random.seed(0)
r = np.random.uniform(0, 1, (N, 2))
f = np.zeros_like(r)
q = np.random.uniform(-1, 1, N)
m = 1

t = 0
dt = 0.001
T = 0.1

while t < T:
    F(f, r, q)
    r += f*dt*dt/m
    t += dt

end = time.time()
print(end - begin)
