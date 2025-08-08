option(BUILD_BENCHMARK "build benchmark" OFF)

if(BUILD_BENCHMARK)
    message(STATUS "Building benchmark is ENABLED")
    #add support for tests. Inside the CMakeLists.txt
    #inside test/, there are all the test modules.
    #using this structure, different flags can be defined
    #to only import certain tests to be run.
    add_subdirectory(${CMAKE_SOURCE_DIR}/benchmark)

else()
    message(STATUS "Building benchmark is DISABLED")
endif()

