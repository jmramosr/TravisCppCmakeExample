cmake_minimum_required(VERSION 3.10)

# Make PROJECT_SOURCE_DIR, PROJECT_BINARY_DIR, and PROJECT_NAME available.
set(PROJECT_NAME project1)
project(${PROJECT_NAME})

set(PROJECT_DIR ${PROJECT_SOURCE_DIR})
message("${BoldYellow}PROJECT_DIR: ${PROJECT_DIR}${ColourReset}")

include(internal_utils.cmake)

########################################
########  Directories assorted  ########
########################################
set(common_includes ${PROJECT_SOURCE_DIR}/include)
message("${BoldBlue}common_includes: ${common_includes}${ColourReset}")
set(gtest_includes "${PROJECT_SOURCE_DIR}/lib/gtest/googletest/include")
message("${BoldBlue}gtest_includes: ${gtest_includes}${ColourReset}")
set(gmock_includes "${PROJECT_SOURCE_DIR}/lib/gtest/googlemock/include")
message("${BoldBlue}gmock_includes: ${gmock_includes}${ColourReset}")

###############################
########  C++98 Files  ########
###############################
file(GLOB SRC_CXX_98_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp)
message("${Orangeybg}SRC_CXX_98_FILES: ${SRC_CXX_98_FILES}${ColourReset}")
set(cxx98_flags "-g -fprofile-arcs -ftest-coverage") # The flags passed to the compiler to get coverage on Cygwin/Travis/Unix/Linux
set(cxx98_libs "-lgcov") # The libraries used to compile the C++98 code on Cygwin/Travis/Unix/Linux
set(cxx98_objetive "SrcCpp98") # Name of the target
cxx_library_cxx_98("${cxx98_objetive}" "${common_includes}" "${cxx98_flags}" "${cxx98_libs}" "${SRC_CXX_98_FILES}")

###############################
########  C++11 Files  ########
###############################
# file(GLOB SRC_CXX_11_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp)
# message("${Orangeybg}SRC_CXX_11_FILES: ${SRC_CXX_11_FILES}${ColourReset}")
###############################
#          WARNING
# In this example there is not any C++11 files
# Example of how to do the C++11 compiling
###############################
# set(cxx11_objetive "SrcCpp11") # Name of the target
# file(GLOB SRC_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp) # The files to be listed into SRC_FILES
# message("${Grayishbg}SRC_FILES: ${SRC_FILES}${ColourReset}")
# set(cxxtests_flags "-g -Wall -pedantic -O0") # The flags passed to the compiler on Cygwin/Travis/Unix/Linux
# set(cxxtests_libs "-lm -lrt -lstdc++ -pthread") # The libraries used to compile the tests on Cygwin/Travis/Unix/Linux
# cxx_library_cxx_11("${cxx11_objetive}" "${common_includes}" "${cxx11_flags}" "${cxx11_libs}" "${SRC_FILES}")

##########################################
########  Output test executable  ########
##########################################
file(GLOB TEST_FILES ${PROJECT_SOURCE_DIR}/test/*.cpp)
message("${Grayishbg}TEST_FILES: ${TEST_FILES}${ColourReset}")
set(outputUnitTest "RunUnitTests") # Name of the target
message("${Magenta}Preparing ${outputUnitTest}${ColourReset}")
# Create the list of folders involved in the test folder items
# https://stackoverflow.com/questions/7533502/how-can-i-merge-multiple-lists-of-files-together-with-cmake
set(include_folders_to_test ${common_includes} ${gtest_includes} ${gmock_includes})
set(outputUnitTest_flags "-g -Wall -pedantic -O0") # The flags passed to the compiler on Cygwin/Travis/Unix/Linux
set(outputUnitTest_libs "-lgtest_main -lgtest -lm -lrt -lstdc++ -pthread" ${cxxtests_objetive} ${cxx98_objetive})
gtest_executable("${outputUnitTest}" "${include_folders_to_test}" "${outputUnitTest_flags}" "${outputUnitTest_libs}" "${TEST_FILES}")

################################
########  Dependencies  ########
################################
# https://cmake.org/pipermail/cmake/2008-January/019020.html
add_dependencies("${outputUnitTest}" "${cxx98_objetive}")
###############################
#          WARNING
# outputUnitTest depends of cxx98_objetive!


#############################
########  Execution  ########
#############################
# To execute the tests in this example, we must put a custom target to run them
add_custom_target(Execute_tests ALL
  COMMAND bin/${outputUnitTest}
  DEPENDS ${outputUnitTest}
  COMMENT "Executing the tests..."
  VERBATIM)
  
