subroutine print_info
! print configuration/build info by the executable
#include "git_info.h"
#include "build_info.h"

use iso_c_binding
interface
  subroutine print_mathlibs() bind(c) 
  end subroutine print_mathlibs
  subroutine print_explicitlibs() bind(c) 
  end subroutine print_explicitlibs
end interface

 print *,"--------- Configuration and build info ---------------"

 print *,"     Operating system      : ",SYSTEM
 print *,"     CMake version         : ",CMAKE_VERSION
 print *,"     CMake generator       : ",CMAKE_GENERATOR

 print *,"     CMake build type      : ",CMAKE_BUILD_TYPE

 print *,"          Fortran compiler : ",FORTRAN_COMPILER
 print *,"  Fortran compiler version : ",FORTRAN_COMPILER_VERSION
 print *,"    Fortran compiler flags : ",FORTRAN_COMPILER_FLAGS
 print *,"            Static linking : ",STATIC_LINKING

 ! use the C routine to print long MATH_LIBS, EXPLICIT_LIBS strings
 call print_mathlibs
 call print_explicitlibs

 print *,"            Git branch     : ",GIT_BRANCH
 print *,"      Last git commit hash : ",GIT_COMMIT_HASH
 print *,"    Last git commit author : ",GIT_COMMIT_AUTHOR
 print *,"      Last git commit date : ",GIT_COMMIT_DATE

 print *,"---------------------------------------------------------"

end subroutine print_info


