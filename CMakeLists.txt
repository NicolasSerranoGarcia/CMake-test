#---General---#

#set the minimum required version of CMake that other computers must use for this program
cmake_minimum_required(VERSION 3.15)

#set the project name
project(CMakeTest VERSION 1.0)

#---Set compiler flags---#

#Create a flags library
add_library(CMakeTest_compiler_flags INTERFACE)
#set the c++ standard to be C++11.
#Every library or executable that links this library will be required to have C++11
#Interface here represents that the attribute itself does not apply to the library, but to 
#the ones who link it
target_compile_features(CMakeTest_compiler_flags INTERFACE cxx_std_11)

#create two variables to check which compile does the user have.
#In this case we are distinguishing between Linux/MacOS and Windows.
#This is useful because the flags from gcc are not the same used in MSVC
set(is_gcc-type_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(is_msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

target_compile_options(CMakeTest_compiler_flags INTERFACE 
                        "$<${is_gcc-type_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
                        "$<${is_msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

#---Create executable---#

#create the executable from the main function.
#This executable can the be linked with other libraries you have created.
add_executable(Executable
  src/main.cc
)

#---Link the project libraries---#

target_link_libraries(Executable PRIVATE src/MyPrivateClass/MyPrivateClass.cc)


#Suppose now we need to add a class that is defined inside a folder inside our root tree, so called a library. 
#Imagine that this class is reusable and we wanted other classes or executables, or even the main program to work with it

#We can create a second CMakeLists.txt to reference that library.
#IF we add the directory where that CMakeLists.txt is as a subdirectory, the libraries, executables (for example test executables), variables...
#can now be accessed from this file. 
add_subdirectory(src/MyClass)

#Here we are accessing the library defined in that CMakeLists.txt and linking it to the main executable 
target_link_libraries(Executable PRIVATE MyClassLibrary)

target_link_libraries(Executable INTERFACE CMakeTest_compiler_flags)

#---Add debug flags defined in tools.cmake---#

#We import the flag tools defined inside the tools.cmake
#This way we can use the flags when building
include(cmake/tools.cmake)

#---(Optional

#For example, let's suppose we want to send the executable to the source tree
#for testing purposes
set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/install" CACHE PATH "Installation Directory")
#this will create a directory inside the root of the project called install, if it 
#is not created, and will place everything that is called with install() there.
#If the deployment is automated, the CI/CD tools will make sure the release path changes t

#---Install the executable inside the binary ---#

#As previously we changed the CMAKE_INSTALL_PREFIX env. variable to point to the install directory, when running
#cmake --install ., the Executable will go into install/bin
install(TARGETS Executable DESTINATION bin)

include(CTest)

