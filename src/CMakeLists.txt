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

if(CMAKE_Fortran_COMPILER_ID MATCHES PGI OR CMAKE_Fortran_COMPILER_ID MATCHES
Intel)
    if (LAPACK_TYPE MATCHES ATLAS OR LAPACK_TYPE MATCHES SYSTEM_NATIVE OR
BLAS_TYPE MATCHES ATLAS OR BLAS_TYPE MATCHES SYSTEM_NATIVE)
        set (MATH_LIBS ${MATH_LIBS} -lgfortran)
    endif()
endif()


if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    #windows needs to find <lapacke.h> of openblas 
    include_directories($ENV{PATH})
else()
    #ftravis-ci needs find <clapack.h> of ATLAS
    include_directories(/usr/include/atlas)
endif()

add_executable(example example.F90)
add_executable(example_c example_c.c)

if(LAPACK_FOUND AND BLAS_FOUND)
    target_link_libraries(example ${MATH_LIBS})
    target_link_libraries(example_c ${MATH_LIBS})
elseif (EXPLICIT_LIBS)
    target_link_libraries(example ${EXPLICIT_LIBS})
    target_link_libraries(example_c ${EXPLICIT_LIBS})
else()
    message(FATAL_ERROR "LAPACK/BLAS libraries were not found for this project !")
endif()
