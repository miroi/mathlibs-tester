#include <stdio.h>
#include "build_info.h"

/* printing long string is available in C, not in Fortran */
void print_mathlibs() 
{
    printf("     Mathematical libraries :  %s\n", MATH_LIBS);
}

void print_explicitlibs() 
{
    printf("         Explicit libraries :  %s\n", EXPLICIT_LIBS);
}
