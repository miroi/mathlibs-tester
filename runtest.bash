!#/bin/bash

echo "hello !"
pwd

#python ./setup.py --help

BUILD=build_gfortran
if [[ -d "$BUILD" ]]; then
  echo "deleting previous build directory $BUILD"
  /bin/rm -rf $BUILD
fi
./setup --fc=gfortran  $BUILD
cd $BUILD
make 
ldd bin/example
bin/example


exit 0
