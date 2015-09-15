#include <stdio.h>
#include "build_info.h"

void print_mathlibs() 
/* printing long sring is available in C, not in Fortran */
{
    printf("     Mathematical libraries :  %s\n", MATH_LIBS);
}
