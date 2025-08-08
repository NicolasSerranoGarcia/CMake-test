<!--Add some explanation outside of the CMakeLists.txt and also IMPORTANT add all the commands available for the build and debugging. 
Make a walkthrough of a how a real workflow would go using the commands and what are the results-->
Guide

One should position itself on the folder build/ for executing any of the following commands.

Grouping all useful commands:

ctest -D Experimental   # local
ctest -D Nightly        # daily
ctest -D Continuous     # CI/CD (push, merge, etc.)




"cmake ../" creates the builder (makefiles and libraries)

Creating the build with flags:
Optionally one can build the project with certain flags that enable or disable some tools:

BUilding benchmarks:


cmake ../ -DBUILD_BENCHMARK=<OFF|ON>
by default it is ON

cmake ../ -DBUILD_TESTS=<OFF|ON>
by default it is ON

Sanitizers

cmake .. -DUSE_SANITIZER=Address
cmake .. -DUSE_SANITIZER=Thread
cmake .. -DUSE_SANITIZER=Memory
cmake .. -DUSE_SANITIZER=MemoryWithOrigins
cmake .. -DUSE_SANITIZER=Undefined
cmake .. -DUSE_SANITIZER=Leak
cmake .. -DUSE_SANITIZER="Address;Undefined"  # multiple sanitizer

Static analyzers

cmake .. -DUSE_STATIC_ANALYZER=clang-tidy
cmake .. -DUSE_STATIC_ANALYZER=cppcheck
cmake .. -DUSE_STATIC_ANALYZER=iwyu
cmake .. -DUSE_STATIC_ANALYZER="clang-tidy;iwyu;cppcheck" #multiple sanitizers

installing the project inside the folder install/:

cmake --install .

cmake --build .



cpack -> automated: creates a different package depending on the platform

Doxygen:

generate documentation:

doxygen Doxyfile

general syntax

/**
 * @brief Adds two integers.
 * 
 * This function takes two integers as input and returns their sum.
 * 
 * @param a First integer.
 * @param b Second integer.
 * @return The result of a + b.
 */
int add(int a, int b);


when adding new code or features to the program the general sequence would be

1. if build/ deosn't exist, create it

2. cd build

3. cmake ../ [TOOLS MENTIONED BEFORE IF NEEDED]

4. cmake --build .

5. try the program by yourself and see if the added code works for the case you thought

6. If it seems good at first glance, run the tests: run "ctest".

    6.1 if you are only interested in certain tests, you can run an additional command: ctest -R <regex>
        e.g if you want to run a test whose name contains the word "class" you would run: ctest -R class
        Note: the tests are built with google tests, so a given test has it's name given by:
            <test_suite>.<test_name>
            This means that a certain test can be run by using ctest -R <test_suite>.<test_name>

7. Create new tests for the thing you just created

8. committing to the branch you are currently in. 

9. If there is a CI pipeline, then it should run the tests in each OS to make sure nothing breaks. If not, then you should try it by yourself

10. If something breaks during the CI pipeline, go back to point 3 and fix the problem. Make sure the next commit isn't pushed until you fix the error, or part of it.

11. When the feature is correctly implemented, consider creating a release. If not, accumulate features until you decide to add a release.

General commit message convention:

<type>[optional scope]: <description>

[optional body]

[optional footer(s)]

type = fix|feat|build|chore|ci|docs|style|refactor|perf|test