!#/bin/bash

echo "hello !"
pwd

cd tmp
if [[ -d "mathlibs-tester" ]]; then
  echo "deleting previous clone mathlibs-tester"
  /bin/rm -rf mathlibs-tester
fi
git clone git@github.com:miroi/mathlibs-tester.git

cd  mathlibs-tester

BUILD=build_gfortran
if [[ -d "$BUILD" ]]; then
  echo "deleting previous build directory $BUILD"
  /bin/rm -rf $BUILD
fi
./setup --fc=gfortran  $BUILD
cd $BUILD
make 
ls -lt bin/example
ldd bin/example
bin/example


exit 0
