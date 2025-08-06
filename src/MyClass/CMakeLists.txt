#This CMakeLists.txt is used uniquely to make the .cc and .h a library itself that can be accessed directly by the main.cc or executable files
#It also makes it possible for other libraries (classes) to link the library as a whole directly (instead of adding the .h to the class). 

#We first create the library from the source file.
#the .h is not included
add_library(MyClassLibrary MyClass.cc)

#Then, we make the library visible for the rest of the project by mentioning where the .h is located.
#in this case, it is inside the /include(/MyClass) directory. Now, libraries that link to this one
#via target_link_libraries() can mention "MyClass/MyClass.h" directly.  
target_include_directories(MyClassLibrary PUBLIC ${CMAKE_SOURCE_DIR}/include)

target_link_libraries(MyClassLibrary PUBLIC CMakeTest_compiler_flags)