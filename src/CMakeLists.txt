if(CMAKE_Fortran_COMPILER_ID MATCHES PGI)
    # remove -rdynamic flag offensive to PGI Fortran
    list(REMOVE_ITEM CMAKE_SHARED_LIBRARY_LINK_Fortran_FLAGS "-rdynamic")
    # fix for rand() function
    add_definitions(-DVAR_PGI)
endif()
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
    # prevent ifort's warning
    list(REMOVE_ITEM CMAKE_SHARED_LIBRARY_LINK_Fortran_FLAGS "-i_dynamic")
    add_definitions(-DVAR_INTEL)
endif()

add_executable(example example.F90)
if(LAPACK_FOUND AND BLAS_FOUND)
    target_link_libraries(example ${MATH_LIBS})
elseif (EXPLICIT_LIBS)
    target_link_libraries(example ${EXPLICIT_LIBS})
else()
    message(FATAL_ERROR "LAPACK/BLAS libraries were not found for this project !")
endif()
