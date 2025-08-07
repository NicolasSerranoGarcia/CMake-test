#This file creates an executable for the specific .cc test file contained in the same folder,
#which will also once linked with google tests, so the executable that comes out of this CMakeLists.txt is
# ready to be run, independently of who calls it then
add_executable(my_class_test_usage my_class_test_usage.cc)

#even though the program or the tests may not need Multithreading, in case in a future a threading related feature 
#is implemented, the tests are already loaded to work with threading. It may also happen that other dependencies might
#need threading when using them on the tests, so this is why this is included here
find_package(Threads REQUIRED)

target_link_libraries(my_class_test_usage Threads::Threads)

#create a main entry point for each individual test, instead of creating a single main for every test of the class
target_link_libraries(my_class_test_usage gtest_main)

target_link_libraries(my_class_test_usage my_class_library)

include(GoogleTest)
gtest_discover_tests(my_class_test_usage)