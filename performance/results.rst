=======================================
The mathlibs-tester scaling performance
=======================================

depending on the OpenMP MKL-threading

-  python setup.py --fc=ifort --int64 --mkl=parallel build_ifort_mklpar_i8
-  python setup.py --fc=ifort --int64 --mkl=sequential build_ifort_mklseq_i8

The DGESV (LAPACK); DGEMM (BLAS) and DNRM2(BLAS) library routines are called.

Run as
------
::

 /bin/example N i

where N is the size of the matrix, i is the print level (recommended 1).

The @lxir071.gsi.de interactive server
======================================
Intel(R) Xeon(R) CPU L5506 @ 2.13GHz;  8 CPU 

- export MKL_NUM_THREADS=#
- export MKL_DYNAMIC=false

/bin/example 3000 1
~~~~~~~~~~~~~~~~~~~

===  ======
#     time
===  ======
seq  16.497
1    16.141
2    8.485
4    4.650
8    3.397
===  ======

The @login.grid.umb.sk cluster
==============================
Intel 12 cpu per node, 48GB RAM

- export MKL_NUM_THREADS=#
- export MKL_DYNAMIC=false

/bin/example 7000 1
~~~~~~~~~~~~~~~~~~~~

=== =======
#    time
=== =======
seq  ...
2    ...
4    ...
8    ...
12   ...
=== =======

