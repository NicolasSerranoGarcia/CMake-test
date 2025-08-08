#---General---#

#set the minimum required version of CMake that other computers must use for this program
cmake_minimum_required(VERSION 3.15)

#set the project name
project(CMakeTest VERSION 1.0)

#---Build location---#

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

#---Set compiler flags---#

#Create a flags library
add_library(CMakeTest-compiler-flags INTERFACE)
#set the c++ standard to be C++11.
#Every library or executable that links this library will be required to have C++11
#Interface here represents that the attribute itself does not apply to the library, but to 
#the ones who link it
target_compile_features(CMakeTest-compiler-flags INTERFACE cxx_std_11)

#create two variables to check which compile does the user have.
#In this case we are distinguishing between Linux/MacOS and Windows.
#This is useful because the flags from gcc are not the same used in MSVC
set(is-gcc-type-cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(is-msvc-cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

target_compile_options(CMakeTest-compiler-flags INTERFACE 
                        "$<${is-gcc-type-cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
                        "$<${is-msvc-cxx}:$<BUILD_INTERFACE:-W3>>"
)

#---Add debug flags defined in tools.cmake---#

include(${CMAKE_SOURCE_DIR}/cmake/tools.cmake)

#---Add test enable flag defined in tests.cmake---#

#Note that this module does not add the tests itself, but the flag
#that does. So the tests are only accesible from this CMakeLists.txt
#when the flag BUILD_TESTING is set to true.
include(${CMAKE_SOURCE_DIR}/cmake/test.cmake)

#---Add benchmark enable flag defined in benchmark.cmake---#

#Note that this module does not add the benchmark itself, but the flag
#that does. So the benchmark is only accessible from this CMakeLists.txt
#when the flag BUILD_BENCHMARK is set to true.
include(${CMAKE_SOURCE_DIR}/cmake/benchmark.cmake)

#---Add CPM installer from cmake/---#

include(cmake/CPM.cmake)

#---add google tests with CPM---#

CPMAddPackage(
  NAME GoogleTest
  GITHUB_REPOSITORY google/googletest
  GIT_TAG v1.14.0
  OPTIONS "INSTALL_GTEST OFF"
  OPTIONS "BENCHMARK_DOWNLOAD_DEPENDENCIES=ON"
)

#---Add google benchmark with CPM---#

CPMAddPackage(
  NAME benchmark
  GITHUB_REPOSITORY google/benchmark
  GIT_TAG v1.7.1
  OPTIONS "BENCHMARK_ENABLE_TESTING OFF"
)

#---Create executable---#

#create the executable from the main function.
#This executable can the be linked with other libraries you have created.
add_executable(CMakeTest
  source/main.cc
)

#---link dependencies that are internal---#
target_sources(CMakeTest PRIVATE ${CMAKE_CURRENT_LIST_DIR}/source/my_private_class/my_private_class.cc)

#---Link the project libraries---#
target_link_libraries(CMakeTest INTERFACE CMakeTest-compiler-flags)

#Suppose now we need to add a class that is defined inside a folder inside our root tree, so called a library. 
#Imagine that this class is reusable and we wanted other classes or executables, or even the main program to work with it

#We can create a second CMakeLists.txt to reference that library.
#IF we add the directory where that CMakeLists.txt is as a subdirectory, the libraries, executables (for example test executables), variables...
#can now be accessed from this file.
add_subdirectory(source/my_class)

#Even though the library is private, in order for other CMakeLists.txt from below to access the private class library, we need to add the subdirectory.
#This way, whenever a module wants to use the private library in it's code, we 
add_subdirectory(source/my_private_class)


#Here we are accessing the library defined in that CMakeLists.txt and linking it to the main executable 
target_link_libraries(CMakeTest PRIVATE my_class_library)

#---If there is a need to install (f.e CI/CD release)---#

#For example, let's suppose we want to send the executable to the source tree
#for testing purposes
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_LIST_DIR}/install")
#this will create a directory inside the root of the project called install, if it 
#is not created, and will place everything that is called with install() there.
#If the deployment is automated, the CI/CD tools will specifically create the package to release
#inside install, and then compress it to create a certain release

#---Install the executable inside the binary ---#

#As previously we changed the CMAKE_INSTALL_PREFIX env. variable to point to the install directory, when running
#cmake --install ., the CMakeTest will go into install/bin
install(TARGETS CMakeTest DESTINATION bin)

#Support for CPack

if(WIN32)
    set(CPACK_GENERATOR "ZIP")
elseif(APPLE)
    set(CPACK_GENERATOR "TGZ")
elseif(UNIX)
    set(CPACK_GENERATOR "TGZ")
endif()

include(InstallRequiredSystemLibraries)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.txt")
set(CPACK_PACKAGE_VERSION_MAJOR "${CMakeTest_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${CMakeTest_VERSION_MINOR}")
set(CPACK_SOURCE_GENERATOR "TGZ")
include(CPack)