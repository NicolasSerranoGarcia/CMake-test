#create the executable for the benchmarks
add_executable(${PROJECT_NAME}_benchmark benchmark_main.cc)

#---Once: link google benchmarks with the executable. The rest of the benchmarks get the library from here---#

target_link_libraries(${PROJECT_NAME}_benchmark PUBLIC benchmark::benchmark)

#---Once for each benchmark folder (e.g. my_class_benchmarks/)---#

#---1. my_class_benchmarks---#

#link with benchmarks for my_class
target_sources(${PROJECT_NAME}_benchmark PRIVATE my_class_benchmarks/my_class_benchmarks.cc)

#Make the folder where the my_class_library is defined
target_include_directories(${PROJECT_NAME}_benchmark PRIVATE ${CMAKE_SOURCE_DIR}/source/my_class)

#Link the library for the class
target_link_libraries(${PROJECT_NAME}_benchmark PRIVATE my_class_library)

#---2. ...---#

#---When doing cmake --install . send the executable to the binary dir---#

install(TARGETS ${PROJECT_NAME}_benchmark DESTINATION bin)