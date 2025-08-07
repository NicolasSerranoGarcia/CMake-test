#This file creates an executable for the specific .cc test file contained in the same folder,
#which will also once linked with google tests, so the executable that comes out of this CMakeLists.txt is
# ready to be run, independently of who calls it then
add_executable(my_private_class_test_ui my_private_class_test_ui.cc)


target_include_directories(my_private_class_test_ui PRIVATE
    ${CMAKE_SOURCE_DIR}/source/my_private_class
)

#Access the library created by the CMakeLists.txt inside the private class directory
target_link_libraries(my_private_class_test_ui my_private_class_library)
#We also need to access manually the dependency that the private class has on the public class.
#this is because the library that is created on the private class (for import purposes inside the
#own program) imports the public library privately, so this test must access it too
target_link_libraries(my_private_class_test_ui my_class_library)


#even though the program or the tests may not need Multithreading, in case in a future a threading related feature 
#is implemented, the tests are already loaded to work with threading. It may also happen that other dependencies might
#need threading when using them on the tests, so this is why this is included here
find_package(Threads REQUIRED)

target_link_libraries(my_private_class_test_ui Threads::Threads)

#create a main entry point for each individual test, instead of creating a single main for every test of the class
target_link_libraries(my_private_class_test_ui gtest_main)

include(GoogleTest)
gtest_discover_tests(my_private_class_test_ui)