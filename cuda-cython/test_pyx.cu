Stuff = "Hi"
import numpy as np
cimport numpy as np

cdef extern from "test.cu":
    void cython_add(int *a, int *b, int *result, int N)


def add(int [:] a, int [:] b, int [:] c):
    n = len(b)
    cython_add(&a[0], &b[0], &c[0], n)
