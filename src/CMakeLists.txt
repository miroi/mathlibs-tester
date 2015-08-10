#include(CTest)
#add_test(test COMMAND python setup --help )
#add_test(gfortran_sysnative COMMAND python setup --fc=gfortran; cd build;

message("here CTest:")
include(CTest)
message("CTest: CTEST_PROJECT_NAME=${CTEST_PROJECT_NAME}")

enable_testing()
#add_test(NAME testik WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
#         COMMAND "python setup.py --help")

message("CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")

add_test(t ${PROJECT_BINARY_DIR}/bin/example)

#add_test(NAME t WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
#         COMMAND "${CMAKE_SOURCE_DIR}/setup.py --help")


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
