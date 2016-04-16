########################################################################################
#
# CMake script for getting (from Python script and from CMake variables if defined)
# and comparing compilers versions
#
# At this moment the CMAKE_<LANG>_COMPILER_ID variable must be defined for C, C++ and Fortran: 
# see ConfigCompilerFlags.cmake, otherwise quit with fatal error.
#
# Written by Ivan Hrasko, February 2014.
# 
#########################################################################################

# What is minimum required compiler version depending on vendor? 
# Please add according to your experience. But if you want to specify more numbers 
# or different format than you see here then you must also make changes in GetCompilerVersion.py.
# (because that script matches only as many numbers as you see here)
if(CMAKE_C_COMPILER_ID MATCHES "GNU")
	set(REQUIRED_C "4.1.2")
elseif(CMAKE_C_COMPILER_ID MATCHES "Intel")
	set(REQUIRED_C "10.1")
elseif(CMAKE_C_COMPILER_ID MATCHES "PGI")
	set(REQUIRED_C "12.5")
elseif(CMAKE_C_COMPILER_ID MATCHES "XL")
	set(REQUIRED_C "11.01")
elseif(CMAKE_C_COMPILER_ID MATCHES "Clang")
	set(REQUIRED_C "3.1")
else()
	message(FATAL_ERROR "Vendor of your C compiler is not supported")
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
	set(REQUIRED_CXX "4.1.2")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Intel")
	set(REQUIRED_CXX "10.1")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "PGI")
	set(REQUIRED_CXX "12.5")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "XL")
	set(REQUIRED_CXX "11.01")
elseif(CMAKE_C_COMPILER_ID MATCHES "Clang")
	set(REQUIRED_CXX "3.1")
else()
	message(FATAL_ERROR "Vendor of your C++ compiler is not supported")
endif()

if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
	set(REQUIRED_Fortran "4.3.0")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
	set(REQUIRED_Fortran "10.1")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "PGI")
	set(REQUIRED_Fortran "12.5")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "XL")
	set(REQUIRED_Fortran "11.01")
else()
	message(FATAL_ERROR "Vendor of your Fortran compiler is not supported")
endif()

# get compiler version from Python script for C, C++ and Fortran compilers (C;C++;Fortran -- in form like CMake list)
execute_process(COMMAND ${PYTHON_EXECUTABLE} ${CMAKE_SOURCE_DIR}/cmake/custom/GetCompilerVersion.py 
				${CMAKE_C_COMPILER} ${CMAKE_C_COMPILER_ID} ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_COMPILER_ID} 
				${CMAKE_Fortran_COMPILER} ${CMAKE_Fortran_COMPILER_ID} ${CMAKE_SYSTEM_NAME}
				OUTPUT_VARIABLE PYTHON_OUTPUT)
				
# get versions from python output
list(GET PYTHON_OUTPUT 0 PYTHON_C_VERSION)
list(GET PYTHON_OUTPUT 1 PYTHON_CXX_VERSION)
list(GET PYTHON_OUTPUT 2 PYTHON_Fortran_VERSION)

# cut off \n added by Python print()
string(STRIP ${PYTHON_Fortran_VERSION} PYTHON_Fortran_VERSION)

# write information about minimum required/found compilers versions to a file in build directory
set(filename "${PROJECT_BINARY_DIR}/COMPILERS_VERSIONS.txt")
# create or rewrite the file
file(WRITE ${filename} "Information about minimum required/found compilers versions\n\n")
# next strings are append to the file created before
# write compilers vendors
file(APPEND ${filename} "Compilers vendors (C, C++, Fortran compiler): ")
file(APPEND ${filename} "${CMAKE_C_COMPILER_ID}, ${CMAKE_CXX_COMPILER_ID}, ${CMAKE_Fortran_COMPILER_ID}\n\n")
# write versions found by Python script
file(APPEND ${filename} "Compilers versions found by Python (required/found):\n")
file(APPEND ${filename} "C language compiler:\t\t\t\t${REQUIRED_C}\t/\t${PYTHON_C_VERSION}\n")
file(APPEND ${filename} "C++ language compiler:\t\t\t\t${REQUIRED_CXX}\t/\t${PYTHON_CXX_VERSION}\n")
file(APPEND ${filename} "Fortran language compiler:\t\t\t${REQUIRED_Fortran}\t/\t${PYTHON_Fortran_VERSION}\n\n")

# if available write versions found by CMake
if((CMAKE_C_COMPILER_VERSION) OR (CMAKE_CXX_COMPILER_VERSION) OR (CMAKE_Fortran_COMPILER_VERSION))
    file(APPEND ${filename} "Compilers versions found by CMake (required/found):\n")
    file(APPEND ${filename} "(Note: not available for all compilers)\n")

    if(CMAKE_C_COMPILER_VERSION)
        file(APPEND ${filename} "C language compiler:\t\t\t\t${REQUIRED_C}\t/\t${CMAKE_C_COMPILER_VERSION}\n")
    endif()
    if(CMAKE_CXX_COMPILER_VERSION)
        file(APPEND ${filename} "C++ language compiler:\t\t\t\t${REQUIRED_CXX}\t/\t${CMAKE_CXX_COMPILER_VERSION}\n")
    endif()
    if(CMAKE_Fortran_COMPILER_VERSION)
        file(APPEND ${filename} "Fortran language compiler:\t\t\t${REQUIRED_Fortran}\t/\t${CMAKE_Fortran_COMPILER_VERSION}\n")
    endif()
endif()

# checking for correct version of C compiler
if(CMAKE_C_COMPILER_VERSION)
	# if CMake variable is defined and not empty (CMake 3.0) then it must begins with version string from Python (so they are equal)   
    string(REGEX MATCH "^${PYTHON_C_VERSION}" CMAKE_C_VERSION "${CMAKE_C_COMPILER_VERSION}")
	if(NOT (CMAKE_C_VERSION VERSION_EQUAL PYTHON_C_VERSION))
		message(STATUS 
        "Versions from CMake variable (${CMAKE_C_COMPILER_VERSION}) and Python script (${PYTHON_C_VERSION}) for C compiler are not equal!")
	endif()
	
    # and available version of compiler must be greater or equal than minimum required version
	if(NOT (CMAKE_C_COMPILER_VERSION VERSION_GREATER REQUIRED_C OR CMAKE_C_COMPILER_VERSION VERSION_EQUAL REQUIRED_C))
		message(WARNING "Not supported version of C compiler. Found: ${CMAKE_C_COMPILER_VERSION}, Required: ${REQUIRED_C}")
	endif()
else()
	# if CMake variable is not defined, only compiler version from Python script must be equal or greater
	# than minimum required version
	if(NOT (PYTHON_C_VERSION VERSION_GREATER REQUIRED_C OR PYTHON_C_VERSION VERSION_EQUAL REQUIRED_C))
		message(WARNING "Not supported version of C compiler. Found: ${PYTHON_C_VERSION}, Required: ${REQUIRED_C}")
	endif()
endif()

# checking for correct version of C++ compiler
if(CMAKE_CXX_COMPILER_VERSION)
	# if CMake variable is defined and not empty (CMake 3.0) then it must begins with version string from Python (so they are equal)   
    string(REGEX MATCH "^${PYTHON_CXX_VERSION}" CMAKE_CXX_VERSION "${CMAKE_CXX_COMPILER_VERSION}")
	if(NOT (CMAKE_CXX_VERSION VERSION_EQUAL PYTHON_CXX_VERSION))
		message(WARNING 
        "Versions from CMake variable (${CMAKE_CXX_COMPILER_VERSION}) and Python script (${PYTHON_CXX_VERSION}) for C++ compiler are not equal!")
	endif()
	
    # and available version of compiler must be greater or equal than minimum required version
	if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER REQUIRED_CXX OR CMAKE_CXX_COMPILER_VERSION VERSION_EQUAL REQUIRED_CXX))
		message(WARNING 
        "Not supported version of C++ compiler. Found: ${CMAKE_CXX_COMPILER_VERSION}, Required: ${REQUIRED_CXX}")
	endif()
else()
	# if CMake variable is not defined, only compiler version from Python script must be equal or greater
	# than minimum required version
	if(NOT (PYTHON_CXX_VERSION VERSION_GREATER REQUIRED_CXX OR PYTHON_CXX_VERSION VERSION_EQUAL REQUIRED_CXX))
		message(WARNING "Not supported version of C++ compiler. Found: ${PYTHON_CXX_VERSION}, Required: ${REQUIRED_CXX}")
	endif()
endif()

# checking for correct version of Fortran compiler
if(CMAKE_Fortran_COMPILER_VERSION)
	# if CMake variable is defined and not empty (CMake 3.0) then it must begins with version string from Python (so they are equal)   
    string(REGEX MATCH "^${PYTHON_Fortran_VERSION}" CMAKE_Fortran_VERSION "${CMAKE_Fortran_COMPILER_VERSION}")
	if(NOT (CMAKE_Fortran_VERSION VERSION_EQUAL PYTHON_Fortran_VERSION))
		message(STATUS 
        "Versions from CMake variable (${CMAKE_Fortran_COMPILER_VERSION}) and Python script (${PYTHON_Fortran_VERSION}) for Fortran compiler are not equal!")
	endif()
	
    # and available version of compiler must be greater or equal than minimum required version
	if(NOT (CMAKE_Fortran_COMPILER_VERSION VERSION_GREATER REQUIRED_Fortran OR CMAKE_Fortran_COMPILER_VERSION VERSION_EQUAL REQUIRED_Fortran))
		message(STATUS
        "Not supported version of Fortran compiler. Found: ${CMAKE_Fortran_COMPILER_VERSION}, Required: ${REQUIRED_Fortran}")
	endif()
else()
	# if CMake variable is not defined, only compiler version from Python script must be equal or greater
	# than minimum required version
	if(NOT (PYTHON_Fortran_VERSION VERSION_GREATER REQUIRED_Fortran OR PYTHON_Fortran_VERSION VERSION_EQUAL REQUIRED_Fortran))
		message(WARNING 
		"Not supported version of Fortran compiler. Found: ${PYTHON_Fortran_VERSION}, Required: ${REQUIRED_Fortran}")
	endif()
endif()
