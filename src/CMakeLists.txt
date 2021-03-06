#
generate_git_info_header(${PROJECT_BINARY_DIR} git_info.h)

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

# provide path for autocmake's generated include files
include_directories(${PROJECT_BINARY_DIR})

add_executable(example example.F90 print_info.F90 print_info.c)
if(LAPACK_FOUND AND BLAS_FOUND)
    # check if extra libs present
    if (EXPLICIT_LIBS)
        target_link_libraries(example ${MATH_LIBS} ${EXPLICIT_LIBS})
    else()
        target_link_libraries(example ${MATH_LIBS})
    endif()

elseif (EXPLICIT_LIBS)
    target_link_libraries(example ${EXPLICIT_LIBS})
else()
    message(FATAL_ERROR "LAPACK/BLAS libraries were not found for this project !")
endif()
