[![Build Status](https://travis-ci.org/miroi/mathlibs-tester.svg?branch=master)](https://travis-ci.org/miroi/mathlibs-tester/builds)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/miroi/mathlibs-tester?branch=master&svg=true)](https://ci.appveyor.com/project/miroi/mathlibs-tester/history)
[![Circle CI](https://circleci.com/gh/miroi/mathlibs-tester.svg?style=svg)](https://circleci.com/gh/miroi/mathlibs-tester)
[![wercker status](https://app.wercker.com/status/2101087ed2848ab011fed435c1efc7c4/s/master "wercker status")](https://app.wercker.com/project/bykey/2101087ed2848ab011fed435c1efc7c4)
[![shippable status](https://api.shippable.com/projects/55c5fa6fedd7f2c05299e676/badge?branchName=master)](https://app.shippable.com/projects/55c5fa6fedd7f2c05299e676/builds/latest)
[![magnum-ci status](https://magnum-ci.com/status/84ea5d43ec94be510b7c372be69d09f6.png)](https://magnum-ci.com/public/52e55e31023c9144f57e/builds)



MathLibs tester
===============

Simple Fortran90 program for checking few LAPACK and BLAS mathematical libraries.

The MathLibs tester can also be used to evaluate the performance of internal parallelization of selected routines from the well-know LAPACK and BLAS libraries, which may be in these packages:
- GNU system native
- ATLAS
- ACML
- Intel MKL
- OpenBLAS
- ESSL

The **MathLibs-tester** project is built upon the [autocmake](https://github.com/scisoft/autocmake) CMake plugin composer and serves also its testing.

For the **MathLibs-tester** project online testing see the [CDash-web](https://testboard.org/cdash/index.php?project=MathLibs-tester).


Buildup and usage
-----------------
For example, utilize the commercial ifort compiler with MKL as the prefered library:
~~~
python setup.py --fc=ifort --cmake-options="-DMATH_LIB_SEARCH_ORDER='MKL;OPENBLAS;SYSTEM_NATIVE' build_ifort
cd build_ifort
make all
bin/example
~~~
For more buildup examples, see this [testing script](https://github.com/miroi/mathlibs-tester/blob/master/cdash_scripts/hpcc_umb_runtest.bash).

For the execution performance, see [here](https://github.com/miroi/mathlibs-tester/blob/master/performance/results.rst).

Finally, send me few bucks ;)
[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5NJSDMSN88ZNQ)
