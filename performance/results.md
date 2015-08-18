Software performance
=====================

- depending on the OpenMP MKL-threading

./setup --fc=ifort --int64 --mkl=parallel build_ifort_mklpar_i8
./setup --fc=ifort --int64 --mkl=sequenatial build_ifort_mklseq_i8

The milias@lxir071.gsi.de interactive server
--------------------------------------------

Intel(R) Xeon(R) CPU L5506 @ 2.13GHz;  8 CPU 

export MKL_NUM_THREADS=4
export MKL_DYNAMIC=false

/bin/example 3000 1
~~~~~~~~~~~~~~~~~~~
MKL_NUM_THREADS  
--------------------------
1    16.649 16.349 16.513
2    19.489
4    20.509
8    21.709

mkl=sequential: 16.497; 16.417;15.965

/bin/example 7000 1
~~~~~~~~~~~~~~~~~~~
mkl=sequential: 205.269

mkl=parallel, mkl_dynamic
      false     true
2    208.497   209.537
4    211.145   208.957
8    225.354   226.346

