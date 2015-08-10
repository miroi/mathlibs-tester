if(LAPACK_FOUND)
    if(CMAKE_Fortran_COMPILER_ID MATCHES PGI)
        # remove -rdynamic flag offensive to PGI Fortran
        set(CMAKE_SHARED_LIBRARY_LINK_Fortran_FLAGS)
        # fix for rand() function
        add_definitions(-DVAR_PGI)
    endif()
    if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
        add_definitions(-DVAR_INTEL)
    endif()
    add_executable(example example.F90)
    target_link_libraries(example ${MATH_LIBS})
else()
    message(FATAL_ERROR "LAPACK/BLAS libraries not found for the project!")
endif()


message("here CTest:")
include(CTest)
message("CTest: CTEST_PROJECT_NAME=${CTEST_PROJECT_NAME}")
enable_testing()

message("CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")
message("PROJECT_BINARY_DIR=${PROJECT_BINARY_DIR}")
message("EXECUTABLE_OUTPUT_PATH=${EXECUTABLE_OUTPUT_PATH}")

#include()

add_test(t ${PROJECT_BINARY_DIR}/bin/example)
#add_test(t ${CMAKE_SOURCE_DIR}/src/example.F90)
#add_test(example ${EXECUTABLE_OUTPUT_PATH}/bin/example)

message("from src : PROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR}")
