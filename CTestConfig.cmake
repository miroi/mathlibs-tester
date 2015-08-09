# Script for regulating the CTest part of the build
# (see http://cmake.org/Wiki/CMake/Testing_With_CTest)
set(CTEST_PROJECT_NAME       "autocmake-tester")
set(CTEST_NIGHTLY_START_TIME "00:00:00 UTC")
set(CTEST_DROP_METHOD        "http")
set(CTEST_DROP_SITE          "testboard.org")
set(CTEST_DROP_LOCATION      "/cdash/submit.php?project=autocmake-tester")
set(CTEST_DROP_SITE_CDASH    TRUE)

set(CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS 200)
set(UPDATE_TYPE git)