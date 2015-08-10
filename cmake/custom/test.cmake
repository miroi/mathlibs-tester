include(CTest)
enable_testing()

# this target is compiled before, see src/CMakeFiles.txt
add_test(t ${PROJECT_BINARY_DIR}/bin/example)
