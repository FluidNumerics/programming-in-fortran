#  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
# 
#  Maintainers : support@fluidnumerics.com
#  Official Repository : https://github.com/FluidNumerics/self/
# 
#  Copyright © 2024 Fluid Numerics LLC
# 
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# 
#  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# 
#  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in
#     the documentation and/or other materials provided with the distribution.
# 
#  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from
#     this software without specific prior written permission.
# 
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
#  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
#  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
#  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
cmake_minimum_required(VERSION 3.21)
cmake_policy(VERSION 3.21...3.27)

option(ENABLE_TESTING "Option to enable build of tests. (Default ON)"  ON)
option(ENABLE_SHARED_LIBS "Option to enable build of tests. (Default OFF)"  OFF)

project(shapes VERSION 0.0.0
	DESCRIPTION "Example repository for demonstrating unit tests in Fortran with CMake"
	LANGUAGES Fortran)
	
IF(NOT CMAKE_Fortran_COMPILER_SUPPORTS_F90)
    MESSAGE(FATAL_ERROR "Fortran compiler does not support F90")
ENDIF(NOT CMAKE_Fortran_COMPILER_SUPPORTS_F90)

# Default Fortran compiler flags
# Fortran compiler flags
if( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "GNU" )
    set( CMAKE_Fortran_FLAGS "${CMAKE_FORTRAN_FLAGS} -cpp -ffree-line-length-512" )
    set( CMAKE_Fortran_FLAGS_DEBUG "-g -O0 -C -Wall -fbounds-check -fbacktrace -ffpe-trap=invalid,zero,overflow" )
    set( CMAKE_Fortran_FLAGS_COVERAGE "${CMAKE_Fortran_FLAGS_DEBUG} --coverage")
    set( CMAKE_Fortran_FLAGS_PROFILE "-pg -O3")
    set( CMAKE_Fortran_FLAGS_RELEASE "-O3" )
    set( CMAKE_C_FLAGS_COVERAGE "-g -O0 --coverage")

elseif( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Intel" )
    set( CMAKE_Fortran_FLAGS "-fpp" )
    set( CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -debug all -check all -traceback" )
    set( CMAKE_Fortran_FLAGS_COVERAGE "${CMAKE_Fortran_FLAGS_DEBUG} -prof-gen=srcpos")
    set( CMAKE_Fortran_FLAGS_PROFILE "-O3")
    set( CMAKE_Fortran_FLAGS_RELEASE "-O3" )
    set( CMAKE_C_FLAGS_COVERAGE "-g -O0")

elseif( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "IntelLLVM" )
    set( CMAKE_Fortran_FLAGS "-fpp" )
    set( CMAKE_Fortran_FLAGS_DEBUG "-debug all -check all,nouninit -traceback" )
    set( CMAKE_Fortran_FLAGS_COVERAGE "${CMAKE_Fortran_FLAGS_DEBUG}") # Code coverage not available with ifx
    set( CMAKE_Fortran_FLAGS_PROFILE "-O3")
    set( CMAKE_Fortran_FLAGS_RELEASE "-O3" )
    set( CMAKE_C_FLAGS_COVERAGE "-g -O0")

elseif( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Flang" )
    set( CMAKE_Fortran_FLAGS "-Mpreprocess" )
    set( CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS} -O0 -g -Wall -pedantic -save-temps" )
    set( CMAKE_Fortran_FLAGS_COVERAGE "${CMAKE_Fortran_FLAGS_DEBUG}") # Code coverage not available with ifx
    set( CMAKE_Fortran_FLAGS_PROFILE "-O3")
    set( CMAKE_Fortran_FLAGS_RELEASE "-O3" )
    set( CMAKE_C_FLAGS_COVERAGE "-g -O0")

elseif( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "NVHPC" )
    set( CMAKE_Fortran_FLAGS "-Mpreprocess" )
    set( CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS} -O0 -Wall -C -g -traceback" )
    set( CMAKE_Fortran_FLAGS_COVERAGE "${CMAKE_Fortran_FLAGS_DEBUG}") # Code coverage not available with ifx
    set( CMAKE_Fortran_FLAGS_PROFILE "-O3 -Mstack_arrays -Minfo")
    set( CMAKE_Fortran_FLAGS_RELEASE "-O3 -Mstack_arrays -Minfo" )
    set( CMAKE_C_FLAGS_COVERAGE "-g -O0")
endif()

# Libraries
add_subdirectory(${CMAKE_SOURCE_DIR}/src)

if(ENABLE_TESTING)
    enable_testing()
    add_subdirectory(${CMAKE_SOURCE_DIR}/test)
endif()