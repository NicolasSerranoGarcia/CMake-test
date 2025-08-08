#create a flag that enables the test compilation

include(CTest)

if(BUILD_TESTING)
    message(STATUS "Building tests is ENABLED")
    enable_testing()
    #add support for tests. Inside the CMakeLists.txt
    #inside test/, there are all the test modules.
    #using this structure, different flags can be defined
    #to only import certain tests to be run.
    add_subdirectory(${CMAKE_SOURCE_DIR}/test)
else()
    message(STATUS "Building tests is DISABLED")
endif()

