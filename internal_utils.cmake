# Defines functions and macros useful for building easily

##########################################
########  Setting up GOOGLE TEST  ########
##########################################
set(GOOGLE_TEST_BUILD_DIRECTORY cmake-gtest-build)
set(GOOGLE_TEST_BUILD_OUTPUT ${PROJECT_SOURCE_DIR}/${GOOGLE_TEST_BUILD_DIRECTORY})
# https://stackoverflow.com/questions/3702115/creating-a-directory-in-cmake
file(MAKE_DIRECTORY ${PROJECT_SOURCE_DIR}/${GOOGLE_TEST_BUILD_DIRECTORY})
message("${ColourBold}Directory created at: ${GOOGLE_TEST_BUILD_OUTPUT}${ColourReset}")
set(GOOGLE_TEST_FOLDER_LOCATION ${PROJECT_SOURCE_DIR}/lib/gtest/)
set(GOOGLE_TEST_CMAKE_COMMANDS -Dgtest_build_samples=OFF -Dgtest_build_tests=OFF -Dgmock_build_tests=OFF -Dcxx_no_exception=ON -Dcxx_no_rtti=ON -DCMAKE_COMPILER_IS_GNUCXX=ON)

#########################################
########  Configure GOOGLE TEST  ########
#########################################
execute_process(COMMAND ${CMAKE_COMMAND} ${GOOGLE_TEST_CMAKE_COMMANDS} -B ${GOOGLE_TEST_BUILD_DIRECTORY} -S ${GOOGLE_TEST_FOLDER_LOCATION})

#####################################
########  Build GOOGLE TEST  ########
#####################################
add_custom_target(Building-google-test ALL COMMAND ;)
add_custom_command(TARGET Building-google-test PRE_BUILD
    COMMAND ${CMAKE_COMMAND} --build ${GOOGLE_TEST_BUILD_OUTPUT}
)

#####################################
########  Color definitions  ########
#####################################
# https://stackoverflow.com/questions/18968979/how-to-get-colorized-output-with-cmake
if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(ColourBold  "${Esc}[1m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Yellow      "${Esc}[33m")
  set(Blue        "${Esc}[34m")
  set(Magenta     "${Esc}[35m")
  set(Cyan        "${Esc}[36m")
  set(White       "${Esc}[37m")
  set(BoldRed     "${Esc}[1;31m")
  set(BoldGreen   "${Esc}[1;32m")
  set(BoldYellow  "${Esc}[1;33m")
  set(BoldBlue    "${Esc}[1;34m")
  set(BoldMagenta "${Esc}[1;35m")
  set(BoldCyan    "${Esc}[1;36m")
  set(BoldWhite   "${Esc}[1;37m")
  set(Greenishbg  "${Esc}[30;48;5;114m")
  set(Orangeybg   "${Esc}[30;48;5;130m")
  set(Grayishbg   "${Esc}[30;48;5;66m")
  set(Pinkybg     "${Esc}[30;48;5;168m")
endif()

#########################
########  C++98  ########
#########################
# Defines how the libraries will be created.
## Usage example: cxx_library_with_flags_cxx_98("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_with_flags_cxx_98 name type include_dirs cxx98_flags libs)
  # message("${Magenta}name: ${name}${ColourReset}")
  # message("${Magenta}type: ${type}${ColourReset}")
  # message("${Magenta}include_dirs: ${include_dirs}${ColourReset}")
  # message("${Magenta}cxx98_flags: ${cxx98_flags}${ColourReset}")
  # message("${Magenta}libs: ${libs}${ColourReset}")
  # message("${Magenta}ARGN: ${ARGN}${ColourReset}")
  # type can be either STATIC or SHARED to denote a static or shared library.
  # ARGN refers to additional arguments after 'cxx98_flags'.
  add_library(${name} ${type} ${ARGN})
  include_directories(${include_dirs})
  # Set the output directory for build artifacts
  set_target_properties(${name}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${cxx98_flags} -std=gnu++98")
  # To support mixing linking in static and dynamic libraries, link each
  # library in with an extra call to target_link_libraries.
  foreach (lib "${libs}")
    target_link_libraries(${name} ${lib})
  endforeach()
endfunction()

# Short form of cxx_library_with_flags_cxx98 for dinamic libraries.
## Usage example: cxx_shared_library_cxx_98("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_shared_library_cxx_98 name include_folders cxx98_flags libraries)
  cxx_library_with_flags_cxx_98(${name} SHARED "${include_folders}" "${cxx98_flags}" "${libraries}" ${ARGN})
endfunction()

# Short form of cxx_library_with_flags_cxx98 for static libraries.
## Usage example: cxx_library_cxx_98("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_cxx_98 name include_folders cxx98_flags libraries)
  cxx_library_with_flags_cxx_98(${name} "" "${include_folders}" "${cxx98_flags}" "${libraries}" ${ARGN})
endfunction()

#########################
########  C++11  ########
#########################
# Defines how the libraries will be created.
## Usage example: cxx_library_with_flags_cxx_11("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_with_flags_cxx_11 name type include_dirs cxx11_flags libs)
  # Debugging by message
  # message("${Magenta}name: ${name}${ColourReset}")
  # message("${Magenta}type: ${type}${ColourReset}")
  # message("${Magenta}include_dirs: ${include_dirs}${ColourReset}")
  # message("${Magenta}cxx11_flags: ${cxx11_flags}${ColourReset}")
  # message("${Magenta}libs: ${libs}${ColourReset}")
  # message("${Magenta}ARGN: ${ARGN}${ColourReset}")
  # type can be either STATIC or SHARED to denote a static or shared library.
  # ARGN refers to additional arguments after 'cxx11_flags'.
  add_library(${name} ${type} ${ARGN})
  include_directories(${include_dirs})
  # Set the output directory for build artifacts
  set_target_properties(${name}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${cxx11_flags} -std=gnu++11")
  # To support mixing linking in static and dynamic libraries, link each
  # library in with an extra call to target_link_libraries.
  foreach (lib "${libs}")
    target_link_libraries(${name} ${lib})
  endforeach()
endfunction()

# Short form of cxx_library_with_flags_cxx11 for dinamic libraries.
## Usage example: cxx_shared_library_cxx_11("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_shared_library_cxx_11 name include_folders cxx11_flags libraries)
  cxx_library_with_flags_cxx_11(${name} SHARED "${include_folders}" "${cxx11_flags}" "${libraries}" ${ARGN})
endfunction()

# Short form of cxx_library_with_flags_cxx11 for static libraries.
## Usage example: cxx_library_cxx_11("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_cxx_11 name include_folders cxx11_flags libraries)
  set(NoType "")
  cxx_library_with_flags_cxx_11(${name} "${NoType}" "${include_folders}" "${cxx11_flags}" "${libraries}" ${ARGN})
endfunction()

#######################
########  C99  ########
#######################
# Defines how the libraries will be created.
## Usage example: cxx_library_with_flags_c99("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_with_flags_c99 name type include_dirs c99_flags libs)
  # type can be either STATIC or SHARED to denote a static or shared library.
  # ARGN refers to additional arguments after 'c99_flags'.
  add_library(${name} ${type} ${ARGN})
  include_directories(${include_dirs})
  # Set the output directory for build artifacts
  set_target_properties(${name}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${c99_flags} -std=c99")
  # To support mixing linking in static and dynamic libraries, link each
  # library in with an extra call to target_link_libraries.
  foreach (lib "${libs}")
    target_link_libraries(${name} ${lib})
  endforeach()
endfunction()

# Short form of cxx_library_with_flags_c99 for dinamic libraries.
## Usage example: cxx_shared_library_cxx_99("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_shared_library_cxx_99 name include_folders c99_flags libraries)
  cxx_library_with_flags_cxx_99(${name} SHARED "${include_folders}" "${c99_flags}" "${libraries}" ${ARGN})
endfunction()

# Short form of cxx_library_with_flags_c99 for static libraries.
## Usage example: cxx_library_cxx_99("${myLib}" "" "${include_routes}" "${cxx_coverage}" "${libraries_used}" ${src_files})
function(cxx_library_cxx_99 name include_folders c99_flags libraries)
  cxx_library_with_flags_cxx_99(${name} "" "${include_folders}" "${c99_flags}" "${libraries}" ${ARGN})
endfunction()

##############################
########  Executable  ########
##############################
# Defines how the executable will be created.
## Usage example: gtest_executable("${exeProgam}" "${include_routes}" "${libraries_used}")
function(gtest_executable name include_dirs exe_flags libs)
  # Debugging by message
  # message("${Magenta}name: ${name}${ColourReset}")
  # message("${Magenta}include_dirs: ${include_dirs}${ColourReset}")
  # message("${Magenta}exe_flags: ${exe_flags}${ColourReset}")
  # message("${Magenta}libs: ${libs}${ColourReset}")
  # message("${Magenta}ARGN: ${ARGN}${ColourReset}")
  link_directories(${PROJECT_SOURCE_DIR}/${GOOGLE_TEST_BUILD_DIRECTORY}/lib)
  add_executable(${name} ${ARGN})
  include_directories(${include_dirs})
  # Set the output directory for build artifacts
  set_target_properties(${name}
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
  set_target_properties(${name}
    PROPERTIES
    COMPILE_FLAGS "${exe_flags} -std=gnu++11")
  # To support mixing linking in static and dynamic libraries, link each
  # library in with an extra call to target_link_libraries.
  foreach (lib "${libs}")
    target_link_libraries(${name} ${lib})
  endforeach()
endfunction()

