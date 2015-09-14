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
# Written by Ivan Hrasko, february 2014
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

#! in every call both stdout and stderr are used and merged
#! this is really needed probably only by Intel which uses stderr, 
#! but it probably also makes no problem when used everywhere

#! looking for C compiler version
if C_COMPILER_VENDOR == 'GNU':
    try:
        outputGCC = subprocess.Popen([C_COMPILER, '--version'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputGCC = ''
    
    matchGCC = re.search(r'\d+\.\d+\.\d+', outputGCC)
    if matchGCC:
        GCCversion = matchGCC.group()
    else:
        GCCversion = '0.0.0'

    C_COMPILER_VERSION = GCCversion
elif C_COMPILER_VENDOR == 'Intel':
    try:
        if CMAKE_SYSTEM_NAME == 'Windows':
            outputIntelC = subprocess.Popen([C_COMPILER, '/V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
        else:
            outputIntelC = subprocess.Popen([C_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputIntelC = ''
    
    matchIntelC = re.search(r'\d+\.\d+', outputIntelC)
    if matchIntelC:
        IntelCversion = matchIntelC.group()
    else:
        IntelCversion = '0.0'
			
    C_COMPILER_VERSION = IntelCversion
elif C_COMPILER_VENDOR == 'PGI':
    try:
        outputPGIC = subprocess.Popen([C_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputPGIC = ''
    
    matchPGIC = re.search(r'\d+\.\d+', outputPGIC)
    if matchPGIC:
        PGICversion = matchPGIC.group()
    else:
        PGICversion = '0.0'
			
    C_COMPILER_VERSION = PGICversion
elif C_COMPILER_VENDOR == 'XL':
    try:
        outputXLC = subprocess.Popen([C_COMPILER, '-qversion'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputXLC = ''
    
    matchXLC = re.search(r'\d+\.\d+', outputXLC)
    if matchXLC:
        XLCversion = matchXLC.group()
    else:
        XLCversion = '0.0'
			
    C_COMPILER_VERSION = XLCversion
elif C_COMPILER_VENDOR == 'Clang':
    try:
        outputClangC = subprocess.Popen([C_COMPILER, '--version'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputClangC = ''
    
    matchClangC = re.search(r'\d+\.\d+', outputClangC)
    if matchClangC:
        ClangCversion = matchClangC.group()
    else:
        ClangCversion = '0.0'
			
    C_COMPILER_VERSION = ClangCversion
else:
    #! unknown, not supported vendor
    C_COMPILER_VERSION = '0.0'

#! looking for C++ compiler version
if CXX_COMPILER_VENDOR == 'GNU':
    try:
        outputGXX = subprocess.Popen([CXX_COMPILER, '--version'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputGXX = ''
    
    matchGXX = re.search(r'\d+\.\d+\.\d+', outputGXX)
    if matchGXX:
        GXXversion = matchGXX.group()
    else:
        GXXversion = '0.0.0'

    CXX_COMPILER_VERSION = GXXversion
elif CXX_COMPILER_VENDOR == 'Intel':
    try:
        if CMAKE_SYSTEM_NAME == 'Windows':
            outputIntelCXX = subprocess.Popen([CXX_COMPILER, '/V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
        else:
            outputIntelCXX = subprocess.Popen([CXX_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputIntelCXX = ''
    
    matchIntelCXX = re.search(r'\d+\.\d+', outputIntelCXX)
    if matchIntelCXX:
        IntelCXXversion = matchIntelCXX.group()
    else:
        IntelCXXversion = '0.0'
			
    CXX_COMPILER_VERSION = IntelCXXversion
elif CXX_COMPILER_VENDOR == 'PGI':
    try:
        outputPGICXX = subprocess.Popen([CXX_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputPGICXX = ''
    
    matchPGICXX = re.search(r'\d+\.\d+', outputPGICXX)
    if matchPGICXX:
        PGICXXversion = matchPGICXX.group()
    else:
        PGICXXversion = '0.0'
			
    CXX_COMPILER_VERSION = PGICXXversion
elif CXX_COMPILER_VENDOR == 'XL':
    try:
        outputXLCXX = subprocess.Popen([CXX_COMPILER, '-qversion'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputXLCXX = ''
    
    matchXLCXX = re.search(r'\d+\.\d+', outputXLCXX)
    if matchXLCXX:
        XLCXXversion = matchXLCXX.group()
    else:
        XLCXXversion = '0.0'
			
    CXX_COMPILER_VERSION = XLCXXversion
elif CXX_COMPILER_VENDOR == 'Clang':
    try:
        outputClangCXX = subprocess.Popen([CXX_COMPILER, '--version'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputClangCXX = ''
    
    matchClangCXX = re.search(r'\d+\.\d+', outputClangCXX)
    if matchClangCXX:
        ClangCXXversion = matchClangCXX.group()
    else:
        ClangCXXversion = '0.0'
			
    CXX_COMPILER_VERSION = ClangCXXversion
else:
    #! unknown, not supported vendor
    CXX_COMPILER_VERSION = '0.0'

#! looking for Fortran compiler version
if Fortran_COMPILER_VENDOR == 'GNU':
    try:
        outputGFORTRAN = subprocess.Popen([Fortran_COMPILER, '--version'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputGFORTRAN = ''
    
    matchGFORTRAN = re.search(r'\d+\.\d+\.\d+', outputGFORTRAN)
    if matchGFORTRAN:
        GFORTRANversion = matchGFORTRAN.group()
    else:
        GFORTRANversion = '0.0.0'

    Fortran_COMPILER_VERSION = GFORTRANversion
elif Fortran_COMPILER_VENDOR == 'Intel':
    try:
        if CMAKE_SYSTEM_NAME == 'Windows':
            outputIntelFORTRAN = subprocess.Popen([Fortran_COMPILER, '/V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
        else:
            outputIntelFORTRAN = subprocess.Popen([Fortran_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputIntelFORTRAN = ''
    
    matchIntelFORTRAN = re.search(r'\d+\.\d+', outputIntelFORTRAN)
    if matchIntelFORTRAN:
        IntelFORTRANversion = matchIntelFORTRAN.group()
    else:
        IntelFORTRANversion = '0.0'
			
    Fortran_COMPILER_VERSION = IntelFORTRANversion
elif Fortran_COMPILER_VENDOR == 'PGI':
    try:
        outputPGIFORTRAN = subprocess.Popen([Fortran_COMPILER, '-V'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputPGIFORTRAN = ''
    
    matchPGIFORTRAN = re.search(r'\d+\.\d+', outputPGIFORTRAN)
    if matchPGIFORTRAN:
        PGIFORTRANversion = matchPGIFORTRAN.group()
    else:
        PGIFORTRANversion = '0.0'
			
    Fortran_COMPILER_VERSION = PGIFORTRANversion
elif Fortran_COMPILER_VENDOR == 'XL':
    try:
        outputXLFORTRAN = subprocess.Popen([Fortran_COMPILER, '-qversion'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]
    except:
        outputXLFORTRAN = ''
    
    matchXLFORTRAN = re.search(r'\d+\.\d+', outputXLFORTRAN)
    if matchXLFORTRAN:
        XLFORTRANversion = matchXLFORTRAN.group()
    else:
        XLFORTRANversion = '0.0'
			
    Fortran_COMPILER_VERSION = XLFORTRANversion
else:
    #! unknown, not supported vendor
    Fortran_COMPILER_VERSION = '0.0'


#! this is the standard output for CMake (must be in this order and with ;)
print C_COMPILER_VERSION + ';' + CXX_COMPILER_VERSION + ';' + Fortran_COMPILER_VERSION
