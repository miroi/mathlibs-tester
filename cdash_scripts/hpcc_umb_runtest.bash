#!/bin/bash

#
#  crontab prescription of HPC UMB BB cluster
#---------------------------------------------
#
#30 01 * * 1,2,3,4,5,6,7 MT=/home/milias/Work/qch/software/software_projects/mathlibs-tester; cd $MT; nohup $MT/cdash_scripts/hpcc_umb_runtest.bash > $MT/buildup.log 2>&1
#
#

echo "Working host is: "; hostname -f

source /mnt/apps/intel/bin/compilervars.sh intel64
echo "Intel Fortran/C/C++ noncommercial compilers with MKL library activated, PROD_DIR=$PROD_DIR."

source /mnt/apps/pgi/environment.sh
echo "Portlang Group compilers activated ! PGI=$PGI"

echo "My PATH=$PATH"
echo "Running on host `hostname`"
echo "Time is `date`"
echo "Directory is `pwd`"
# Define number of processors
NPROCS=`cat /proc/cpuinfo | grep processor | wc -l`
echo "This node has $NPROCS CPUs."

timestamp1=`date +\%F_\%k-\%M-\%S`; timestamp=${timestamp1// /};
echo -e "\n\n Running cdash buildups at "$timestamp ; echo -e "\n\n"

export MATH_ROOT=/mnt/apps/intel/mkl; echo "Activated MATH_ROOT=$MATH_ROOT"
export LC_ALL=C
#export MKL_NUM_THREADS=${NPROCS}
export MKL_NUM_THREADS=1
export MKL_DYNAMIC="FALSE"
export OMP_NUM_THREADS=1
#

cd /tmp/.
if [[ -d "mathlibs-tester" ]]; then
  echo "deleting previous clone of mathlibs-tester"
  /bin/rm -rf mathlibs-tester
fi
echo "cloning the mathlibs-tester ..."
git clone git@github.com:miroi/mathlibs-tester.git

cd mathlibs-tester

#cd cmake
#python update.py --self
#python update.py ..
# return to the main directory
#cd ..

###################################
#
#  GNU gfortran  compiler
#
###################################


BUILD=build_gfortran_atlas_dynamic
python ./setup.py --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER=ATLAS -D BUILDNAME='HPC-UMB_gfortran_atlas_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_gfortran_atlas_static
python ./setup.py --fc=gfortran --static  --cmake-options="-DMATH_LIB_SEARCH_ORDER=ATLAS -D BUILDNAME='HPC-UMB_gfortran_atlas_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_gfortran_system_native_dynamic
python ./setup.py --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER=SYSTEM_NATIVE -D BUILDNAME='HPC-UMB_gfortran_systemnative_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_gfortran_system_native_static
python ./setup.py --fc=gfortran --static  --cmake-options="-DMATH_LIB_SEARCH_ORDER=SYSTEM_NATIVE -D BUILDNAME='HPC-UMB_gfortran_systemnative_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_gfortran_openblas_systemnative_dynamic
python ./setup.py --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER='OPENBLAS;SYSTEM_NATIVE' -D BUILDNAME='HPC-UMB_gfortran_openblas_sysnative_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_gfortran_openblas_systemnative_static
python ./setup.py --static  --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER='OPENBLAS;SYSTEM_NATIVE' -D BUILDNAME='HPC-UMB_gfortran_openblas_sysnative_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..



#######################################################
#
#            Intel ifort compiler
#
#######################################################

BUILD=build_ifort_mkl_int64_dynamic
python ./setup.py --fc=ifort  --int64 --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_ifort_mkl_i8_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_ifort_mkl_int64_static
python ./setup.py --static --fc=ifort  --int64 --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_ifort_mkl_i8_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_ifort_mkl_dynamic
python ./setup.py --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_ifort_mkl_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_ifort_mkl_static
python ./setup.py --static  --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_ifort_mkl_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_ifort_atlas_dynamic
python ./setup.py --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='ATLAS' -D BUILDNAME='HPC-UMB_ifort_atlas_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_ifort_atlas_static
python ./setup.py --static --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='ATLAS' -D BUILDNAME='HPC-UMB_ifort_atlas_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_ifort_systemnative_dynamic
python ./setup.py --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='SYSTEM_NATIVE' -D BUILDNAME='HPC-UMB_ifort_systemnative_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_ifort_systemnative_static
python ./setup.py --static --fc=ifort  --cmake-options="-DMATH_LIB_SEARCH_ORDER='SYSTEM_NATIVE' -D BUILDNAME='HPC-UMB_ifort_systemnative_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

######################################################################
#
#               PGI pgf90 compiler
#
######################################################################

BUILD=build_pgf90_mkl_int64_dynamic
python ./setup.py --fc=pgf90  --int64 --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_i8_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_pgf90_mkl_int64_static
python ./setup.py --fc=pgf90  --int64 --static --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_i8_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_pgf90_mkl_dynamic
python ./setup.py --fc=pgf90  --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_pgf90_mkl_static
python ./setup.py --fc=pgf90 --static  --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_pgf90_atlas_dynamic
python ./setup.py --fc=pgf90  --cmake-options="-DMATH_LIB_SEARCH_ORDER='ATLAS;MKL' -D BUILDNAME='HPC-UMB_pgf90_atlas_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_pgf90_atlas_static
python ./setup.py --fc=pgf90 --static --cmake-options="-DMATH_LIB_SEARCH_ORDER='ATLAS;MKL' -D BUILDNAME='HPC-UMB_pgf90_atlas_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..


BUILD=build_pgf90_systemnative_dynamic
python ./setup.py --fc=pgf90  --cmake-options="-DMATH_LIB_SEARCH_ORDER='SYSTEM_NATIVE;ATLAS;MKL' -D BUILDNAME='HPC-UMB_pgf90_systemnative_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_pgf90_systemnative_static
python ./setup.py --fc=pgf90 --static --cmake-options="-DMATH_LIB_SEARCH_ORDER='SYSTEM_NATIVE;ATLAS;MKL' -D BUILDNAME='HPC-UMB_pgf90_systemnative_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

echo -e  "\n\n All tests finished at `date`"

exit 0
