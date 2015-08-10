!#/bin/bash

echo "hello !"
pwd

cd /tmp/.
if [[ -d "mathlibs-tester" ]]; then
  echo "deleting previous clone of mathlibs-tester"
  /bin/rm -rf mathlibs-tester
fi
echo "cloning again ..."
git clone git@github.com:miroi/mathlibs-tester.git

cd mathlibs-tester

BUILD=build_gfortran_atlas_dynamic
python ./setup.py --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER=ATLAS -D BUILDNAME='HPC-UMB_gfortran_atlas_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_gfortran_system_native_dynamic
python ./setup.py --fc=gfortran  --cmake-options="-DMATH_LIB_SEARCH_ORDER=SYSTEM_NATIVE -D BUILDNAME='HPC-UMB_gfortran_sysnative_dynamic' " $BUILD
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


BUILD=build_ifort_mkl_int64_dynamic
python ./setup.py --fc=ifort  --int64 --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_ifort_mkl_i8_dynamic' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

BUILD=build_pgf90_mkl_int64_dynamic
python ./setup.py --fc=pgf90  --int64 --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_i8_dynamic' " $BUILD
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

BUILD=build_pgf90_mkl_int64_static
python ./setup.py --fc=pgf90 --int64 --static  --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL' -D BUILDNAME='HPC-UMB_pgf90_mkl_i8_static' " $BUILD
cd $BUILD
make VERBOSE=1
ls -lt bin/example
ldd bin/example
bin/example
make Experimental
cd ..

exit 0
