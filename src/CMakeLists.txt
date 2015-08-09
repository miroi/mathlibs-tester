include(CTest)

add_test(test COMMAND python setup --help )
add_test(gfortran_sysnative COMMAND python setup --fc=gfortran; cd build;
make; bin/example)


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
