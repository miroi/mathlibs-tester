subroutine print_info
! print configuration/build info by the executable
#include "git_info.h"
#include "build_info.h"

 print *,"--------- Configration and build info ---------------"
 print *,"      last git commit hash:",GIT_COMMIT_HASH
 print *,"    last git commit author:",GIT_COMMIT_AUTHOR
 print *,"      last git commit date:",GIT_COMMIT_DATE

 print *,"          Fortran compiler :",FORTRAN_COMPILER
 print *,"    Fortran compiler flags :",FORTRAN_COMPILER_FLAGS
 print *,"            static linking :",STATIC_LINKING

 print *,"---------------------------------------------------------"

end subroutine print_info


