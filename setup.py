from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext as build_pyx
import numpy
 
setup(name = 'gravcython', ext_modules=[Extension('gravcython', ['gravcython.pyx'], include_dirs=[numpy.get_include()], extra_compile_args=['-O3'], extra_link_args=['-O3'])], cmdclass = { 'build_ext': build_pyx })

