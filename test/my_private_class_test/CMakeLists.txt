#pack all the test executables inside a discoverable project
#This file is just like saying "Here are all the tests (ready to be run)
#that belong to my_class". When including the directory where this CMakeLists.txt
#is, all the executables will be available
add_subdirectory(my_private_class_test_loading)
add_subdirectory(my_private_class_test_ui)