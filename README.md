# TravisCppCmakeExample
Example to make CI with travis with C++98, C++11 or C example code and gtest to test it, sonarcloud to track smells and codecov to check the code covered by tests. I'm not responsible of the code granted by the example.

[![codecov](https://codecov.io/gh/jmramosr/TravisCppCmakeExample/branch/master/graph/badge.svg)](https://codecov.io/gh/jmramosr/TravisCppCmakeExample) [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppCmakeExample&metric=coverage)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppCmakeExample) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=jmramosr_TravisCppCmakeExample&metric=alert_status)](https://sonarcloud.io/dashboard?id=jmramosr_TravisCppCmakeExample) [![Quality Gate Status](https://travis-ci.com/jmramosr/TravisCppCmakeExample.svg?branch=master&status=created)](https://travis-ci.com/github/jmramosr/TravisCppCmakeExample)

## How to use this example in your project.

🔘 You will need a **computer** with **a web browser** installed and **a Github account**. You can use another code hosting, but I'm not responsible of the bad results or local baldness originated by a misuse of your code hosting site.

🔘 When you have a Github account, go to https://travis-ci.com/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://sonarcloud.io/ and login using your Github account. If you pay them, you can use it for private repositories, too. Skip this step if you have logged in previously or have an account on their site.

🔘 When you have a Github account, go to https://codecov.io/ and login using your Github account. Skip this step if you have logged in previously or have an account on their site.

🔘 Fork this repo. Now you will have a fully functional repo for your C++ projects using google tests and cmake, with code coverage made by codecov and sonarcloud, but you have to activate that functionality first.

🔘 Link your fork in Travis. Google the process if you don't know how to do it.

🔘 Adjust the secret tokens provided by sonarcloud and codecov. Codecov uses the CODECOV_TOKEN on Travis-CI, and sonarcloud, SONAR_TOKEN on Travis-CI, too. Very straightfordward.

🔘 Edit the cpp files in src, include and test and commit the changes. Check if Travis starts a build. If Travis is working, the setup of your web-CI environment is complete!

### Now, the hard part.

🔘 Modify CMakeLists.txt to adjust to your project needs. I placed a google test submodule inside `/lib/gtest/` and place the include directories in the lines 15-20. The `message`s are intended to make a visual confirmation of where are they.

🔘 _project1_ in the line 4 of CMakeLists.txt can be changed by the name you want. Every place you will see a `# Name of the target` can be replaced to the name you want. Replace only the content inside quotes.

🔘 If you need to add more libraries, check the different parts inside number signs or hashes (#) in three different C and C++ flavours: C++98, C++11, C99. You can copy the structure to add new folders of source files, add compilation flags or libraries

🔘 The CMake functions `cxx_library_cxx_11`, `cxx_library_cxx_98` and `c_library_c99` will output an static library (a .lib or .a), in contrast to `cxx_shared_library_cxx_11`, `cxx_shared_library_cxx_98` and `c_shared_library_c99` functions will emit a shared library (.solib, .so, .dll in most operating systems)

🔘 The CMake function `gtest_executable` needs the test files in order to create an executable file. The `Execute_tests` target will execute the compiled output from the `gtest_executable` and, if it fails, Travis-CI will show an error.

### Push harder! Use it offline

🔘 If you want to use it offline, you can download the repo (or checkout the repo and the submodules-remember: `git submodule update --init --recursive`-) and you will need Cmake (I recommend the last version), make, gcov, lcov, gcovr (therefore, python), and a C++11 compiler (clang or gcc preferred) in order to make it work. I use cygwin to make it work under windows, I left to you the checks in other operating systems.

🔘 Go to the repo folder and execute `cmake -Dgtest_build_samples=OFF -Dgtest_build_tests=OFF -Dgmock_build_tests=OFF -Dcxx_no_exception=ON -Dcxx_no_rtti=ON -DCMAKE_COMPILER_IS_GNUCXX=ON -S ./lib/gtest -B ./cmake-gtest-build`. In Travis-CI, I use a different command to output the same results, becuase Travis' CMake doesn't have any `-S` or `-B`. When finished, execute `cmake --build cmake-gtest-build/` and wait it finishes. Google test will be compiled in the folder `./cmake-gtest-build/lib`

🔘 In the same repo folder, execute `cmake -S . -B ./build`. It will start to configure the project. When finished, execute `cmake --build ./build` and wait it finishes. It will execute automatically the tests and, if they fail, cmake will prompt a message It failed.

### The hardest part off all: your work it's not so pretty as you may think.

🔘 Your turn: do your work filling tests, mocks or everything you will need, the code to make the tests pass in the order you want. Pay special attention to the libraries your project will need and ensure a better codebase.

## Warnings

⬜️ As long as google test will need C++11, you must use a C++11 compilant compiler (or even greater).

⬜️ Tested on cygwin under windows 10 and tested on Travis-CI only.
