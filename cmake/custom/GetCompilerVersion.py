#!/usr/bin/env python
#
# Script to determine and verify compilers (C, C++ and Fortran) versions.
# For each vendor/system it calls compiler specific command (like "<path>/gcc --version")
# returning compiler version. We will check version of compiler specified by setup --cc --cxx --fc
# options. These compilers are saved with paths in CMAKE_<LANG>_COMPILER variables.
#
# explanation of params:
# ${CMAKE_<LANG>_COMPILER} - full path to <LANG> compiler -- we need it to call correct command 
# ${CMAKE_<LANG>_COMPILER_ID} - vendor of <LANG> compiler -- we need it to call correct parameter to obtain version
# ${CMAKE_SYSTEM_NAME} - operating system name -- we need it if some compiler has different parameters on different systems
#
# This script returns (as stdout) for CMake a list of 3 strings - compilers versions - separated by semicolons.
#
# Written by Ivan Hrasko, February 2014
# Simplified by Miro Ilias, September 2015
#

import sys, subprocess, re

#! path to the compiler and its vendor
C_COMPILER = sys.argv[1]
C_COMPILER_VENDOR = sys.argv[2]

CXX_COMPILER = sys.argv[3]
CXX_COMPILER_VENDOR = sys.argv[4]

Fortran_COMPILER = sys.argv[5]
Fortran_COMPILER_VENDOR = sys.argv[6]
#! operating system name
CMAKE_SYSTEM_NAME = sys.argv[7]

def get_compiler_version(compiler,version_flag,pattern):
    """
    Get compiler version based on entering aruments:
      compiler - full path to the compiler 
      version_flag - flag to print compiler version
      pattern - the regular expression to extract compiler version numbers
    """
#! in every call both stdout and stderr are used and merged
#! this is really needed probably only by Intel which uses stderr, 
#! but it probably also makes no problem when used everywhere
    try:
        output_compiler = subprocess.Popen([compiler,version_flag], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        output_compiler = ''
    match_compiler = re.search(pattern, output_compiler.decode('utf-8'))
    if match_compiler:
        compiler_version = match_compiler.group()
    else:
        compiler_version = '0.0'
    return compiler_version


#! looking for C compiler version
if C_COMPILER_VENDOR == 'GNU':
    C_COMPILER_VERSION = get_compiler_version(C_COMPILER,'--version','\d+\.\d+\.\d+')
elif C_COMPILER_VENDOR == 'Intel':
    if CMAKE_SYSTEM_NAME == 'Windows':
        C_COMPILER_VERSION = get_compiler_version(C_COMPILER,'\V','\d+\.\d+')
    else:
        C_COMPILER_VERSION = get_compiler_version(C_COMPILER,'-V','\d+\.\d+')
elif C_COMPILER_VENDOR == 'PGI':
    C_COMPILER_VERSION = get_compiler_version(C_COMPILER,'-V','\d+\.\d+')
elif C_COMPILER_VENDOR == 'XL':
    C_COMPILER_VERSION = get_compiler_version(C_COMPILER,'-qversion','\d+\.\d+')
elif C_COMPILER_VENDOR == 'Clang':
    C_COMPILER_VERSION =  get_compiler_version(C_COMPILER,'--version','\d+\.\d+')
else:
    #! unknown, not supported vendor
    C_COMPILER_VERSION = '0.0'

#! looking for C++ compiler version
if CXX_COMPILER_VENDOR == 'GNU':
    CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'--version','\d+\.\d+\.\d+')
elif CXX_COMPILER_VENDOR == 'Intel':
    if CMAKE_SYSTEM_NAME == 'Windows':
        CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'/V','\d+\.\d+\.\d+')
    else:
        CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'-V','\d+\.\d+\.\d+')
elif CXX_COMPILER_VENDOR == 'PGI':
    CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'-V','\d+\.\d+')
elif CXX_COMPILER_VENDOR == 'XL':
    CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'-qversion','\d+\.\d+')
elif CXX_COMPILER_VENDOR == 'Clang':
    CXX_COMPILER_VERSION = get_compiler_version(CXX_COMPILER,'--version','\d+\.\d+')
else:
    #! unknown, not supported vendor
    CXX_COMPILER_VERSION = '0.0'

#! looking for Fortran compiler version
if Fortran_COMPILER_VENDOR == 'GNU':
    Fortran_COMPILER_VERSION = get_compiler_version(Fortran_COMPILER,'--version','\d+\.\d+\.\d+')
elif Fortran_COMPILER_VENDOR == 'Intel':
    if CMAKE_SYSTEM_NAME == 'Windows':
        Fortran_COMPILER_VERSION = get_compiler_version(Fortran_COMPILER,'/V','\d+\.\d+')
    else:
        Fortran_COMPILER_VERSION = get_compiler_version(Fortran_COMPILER,'-V','\d+\.\d+')
elif Fortran_COMPILER_VENDOR == 'PGI':
    Fortran_COMPILER_VERSION = get_compiler_version(Fortran_COMPILER,'-V','\d+\.\d+')
elif Fortran_COMPILER_VENDOR == 'XL':
    Fortran_COMPILER_VERSION = get_compiler_version(Fortran_COMPILER,'-qversion','\d+\.\d+')
else:
    #! unknown, not supported vendor
    Fortran_COMPILER_VERSION = '0.0'

#! this is the standard output for CMake (must be in this order and with ;)
print(C_COMPILER_VERSION + ';' + CXX_COMPILER_VERSION + ';' + Fortran_COMPILER_VERSION)
