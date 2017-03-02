all: clean
	python setup.py build_ext --inplace

test:
	time python -c 'import grav'
	time python -c 'import gravcython'


clean:
	rm -f *.c
	rm -f *.pyc
	rm -rf __pycache__
	rm -f *.so
	rm -rf build
