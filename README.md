[![Build Status](https://travis-ci.org/miroi/mathlibs-tester.svg?branch=master)](https://travis-ci.org/miroi/mathlibs-tester/builds)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/miroi/mathlibs-tester?branch=master&svg=true)](https://ci.appveyor.com/project/miroi/mathlibs-tester/history)
[![Circle CI](https://circleci.com/gh/miroi/mathlibs-tester.svg?style=svg)](https://circleci.com/gh/miroi/mathlibs-tester)
[![wercker status](https://app.wercker.com/status/2101087ed2848ab011fed435c1efc7c4/s/master "wercker status")](https://app.wercker.com/project/bykey/2101087ed2848ab011fed435c1efc7c4)
[![shippable](https://api.shippable.com/projects/55c5fa6fedd7f2c05299e676/badge/master)](https://api.shippable.com/projects/55c5fa6fedd7f2c05299e676/badge/master)


MathLibs tester
===============

Simple Fortran90 program for checking few LAPACK and BLAS mathematical libraries.

The MathLibs tester can be used to evaluate performance internal parallelization of available mathematical libraries.

Mathematical libraries can be from these packages:
- GNU system native
- ATLAS
- ACML
- Intel MKL
- OpenBLAS
- ESSL

The **MathLibs-tester** project is heavily based on the [autocmake](https://github.com/scisoft/autocmake) CMake plugin composer
and serves also its testing.
