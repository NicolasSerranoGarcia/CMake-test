# this file contains a list of tools that can be activated and downloaded on-demand. Each tool is
# enabled during configuration by passing an additional `-DUSE_<TOOL>=<VALUE>` argument to CMake.
# It enables flags during build phase (when cmake ../ [-DUSE_<TOOL>=<VALUE>])to be used to check 
# for errors, inconsistencies, memory leaks...

# This file is a no-brainer, it can be copy-pasted into any project that uses the same technologies


# only activate tools for top level project, meaning this file will only continue
# past this point if we are executing cmake with the CMakeLists.txt from the root project
if(NOT PROJECT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  return()
endif()

include(${CMAKE_CURRENT_LIST_DIR}/CPM.cmake)

# enables sanitizers support using the the `USE_SANITIZER` flag available values are: Address,
# Memory, MemoryWithOrigins, Undefined, Thread, Leak, 'Address;Undefined'
if(USE_SANITIZER OR USE_STATIC_ANALYZER)
  CPMAddPackage("gh:StableCoder/cmake-scripts#24.04")

  if(USE_SANITIZER)
    include(${cmake-scripts_SOURCE_DIR}/sanitizers.cmake)
    message(STATUS "building with SANITIZER is ON")
  endif()

  if(USE_STATIC_ANALYZER)
    message(STATUS "building with STATIC ANALYZER is ON")
    if("clang-tidy" IN_LIST USE_STATIC_ANALYZER)
      set(CLANG_TIDY
          ON
          CACHE INTERNAL ""
      )
    else()
      set(CLANG_TIDY
          OFF
          CACHE INTERNAL ""
      )
    endif()
    if("iwyu" IN_LIST USE_STATIC_ANALYZER)
      set(IWYU
          ON
          CACHE INTERNAL ""
      )
    else()
      set(IWYU
          OFF
          CACHE INTERNAL ""
      )
    endif()
    if("cppcheck" IN_LIST USE_STATIC_ANALYZER)
      set(CPPCHECK
          ON
          CACHE INTERNAL ""
      )
    else()
      set(CPPCHECK
          OFF
          CACHE INTERNAL ""
      )
    endif()

    include(${cmake-scripts_SOURCE_DIR}/tools.cmake)

    if(${CLANG_TIDY})
      clang_tidy(${CLANG_TIDY_ARGS})
    endif()

    if(${IWYU})
      include_what_you_use(${IWYU_ARGS})
    endif()

    if(${CPPCHECK})
      cppcheck(${CPPCHECK_ARGS})
    endif()
  endif()
endif()

if(NOT USE_SANITIZER)
  message(STATUS "building with SANITIZER is OFF")
endif()

if(NOT USE_STATIC_ANALYZER)
  message(STATUS "building with STATIC_ANALYZER is OFF")
endif()