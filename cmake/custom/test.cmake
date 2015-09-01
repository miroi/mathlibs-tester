include(CTest)
enable_testing()

# this target is compiled before, see src/CMakeFiles.txt
add_test(test_lapack_blas ${PROJECT_BINARY_DIR}/bin/example 50 2)
add_test(test_lapack_blas ${PROJECT_BINARY_DIR}/bin/example 100 2)
add_test(test_clapack_cblas ${PROJECT_BINARY_DIR}/bin/example_c)
