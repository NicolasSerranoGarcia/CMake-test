#This file is created so that even though this is a private library and it is not intended to be used outside the program,
#Tests and other files can still add the directory and add the library in PRIVATE mode
add_library(my_private_class_library STATIC
    my_private_class.cc
    my_private_class.h
)

target_include_directories(my_private_class_library PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(my_private_class_library PRIVATE my_class_library)