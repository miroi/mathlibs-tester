subroutine print_info
! print configuration/build info by the executable
#include "git_info.h"
#include "build_info.h"

 print *,"--------- Configuration and build info ---------------"

 print *,"     Operating system      : ",SYSTEM
 print *,"     CMake version         : ",CMAKE_VERSION
 print *,"     CMake generator       : ",CMAKE_GENERATOR

 print *,"     CMake build type      : ",CMAKE_BUILD_TYPE

 print *,"          Fortran compiler : ",FORTRAN_COMPILER
 print *,"    Fortran compiler flags : ",FORTRAN_COMPILER_FLAGS
 print *,"            Static linking : ",STATIC_LINKING

 print *,"      Last git commit hash : ",GIT_COMMIT_HASH
 print *,"    Last git commit author : ",GIT_COMMIT_AUTHOR
 print *,"      Last git commit date : ",GIT_COMMIT_DATE

 print *,"---------------------------------------------------------"

end subroutine print_info


