message("here custom  CTest:")
include(CTest)
message("CTest: CTEST_PROJECT_NAME=${CTEST_PROJECT_NAME}")
enable_testing()

message("CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")
message("PROJECT_BINARY_DIR=${PROJECT_BINARY_DIR}")
message("EXECUTABLE_OUTPUT_PATH=${EXECUTABLE_OUTPUT_PATH}")

#include()

    add_executable(example1 example.F90)
    target_link_libraries(example1 ${MATH_LIBS})

add_test(test ${PROJECT_BINARY_DIR}/bin/example)
add_test(example1 ${PROJECT_BINARY_DIR}/bin/example1)
