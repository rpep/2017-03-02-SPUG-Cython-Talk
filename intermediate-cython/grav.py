import matplotlib.pyplot as plt
import numpy as np

def F(f, r, q):
    f[:] = 0
    for i, (rval, qval) in enumerate(zip(r, q)):
        for j, (rprime, qprime) in enumerate(zip(r, q)):
            if i != j:
                dr = rval - rprime
                theta = np.arctan2(dr[1], dr[0])
                F = q[i]*q[j]/(4*np.pi*8.854e-12*(dr[0]**2 + dr[1]**2))

                f[i, 0] += F*np.cos(theta)
                f[i, 1] += F*np.sin(theta)
    
N = 300
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

print('Python r[0] = {}'.format(r[0]))
