Software performance
=====================

- depending on the OpenMP MKL-threading

python setup.py --fc=ifort --int64 --mkl=parallel build_ifort_mklpar_i8
python setup.py --fc=ifort --int64 --mkl=sequential build_ifort_mklseq_i8

The DGESV (LAPACK); DGEMM (BLAS); DNRM2(BLAS) library routines called.

The milias@lxir071.gsi.de interactive server
--------------------------------------------

Intel(R) Xeon(R) CPU L5506 @ 2.13GHz;  8 CPU 

export MKL_NUM_THREADS=#
export MKL_DYNAMIC=false

/bin/example 3000 1:
~~~~~~~~~~~~~~~~~~~
#     time
--- ---------------------
seq  16.497
1    16.649 16.349 16.513
2    19.489
4    20.509
8    21.709

/bin/example 7000 1
~~~~~~~~~~~~~~~~~~~
mkl=parallel, mkl_dynamic
#     false     true
--  --------   -------
seq  205.269
2    208.497   209.537
4    211.145   208.957
8    225.354   226.346
----------------------

The milias@login.grid.umb.sk cluster
------------------------------------

/bin/example 7000 1:
~~~~~~~~~~~~~~~~~~~~
#    time
--  -------
seq 144.247
2   147.786
4   149.180   
8   153.020
12  161.729
--  -------

