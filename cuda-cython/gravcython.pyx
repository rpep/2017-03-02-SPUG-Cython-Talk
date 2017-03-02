import matplotlib.pyplot as plt
cimport numpy as np
import numpy as np
import time
begin = time.time()

# Bring in information about externally defined
# function.

cdef extern from "grav.hh":
    void F(double *f, double *r, double *q, int N)
    
def f_wrap(double [:] f, double [:] r, double [:] q, int N):
    F(&f[0], &r[0], &q[0], N)
    
N = 1000
np.random.seed(0)
r = np.random.uniform(0, 1, 2*N)
f = np.zeros_like(r)
q = np.random.uniform(-1, 1, N)
m = 1

t = 0
dt = 0.001
T = 0.1

while t < T:
    f_wrap(f, r, q, N)
    r += f*dt*dt/m
    t += dt

end = time.time()
print(end - begin)
