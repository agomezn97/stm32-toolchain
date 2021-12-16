cmake_minimum_required(VERSION 3.22)

project(
    stm32dev-toolchain 
    VERSION 0.1
    DESCRIPTION "STM32 Development Skeleton"
    LANGUAGES C)


set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

    # Specify and require the C99 standard
    set(CMAKE_C_STANDARD 99)
    set(CMAKE_C_STANDARD_REQUIRED True)

    # Let's ensure -std=cxx instead of -std=gnuxx
    set(CMAKE_C_EXTENSIONS OFF)

    # Docs only available if this is the main app
    find_package(Doxygen)
    if(Doxygen_FOUND)
        add_subdirectory(docs)
    else()
        message(STATUS "Doxygen not found, not building docs")
    endif()

    # Testing only available if this is the main app
    # Note this needs to be done in the main CMakeLists
    # since it calls enable_testing, which must be in the
    # main CMakeLists.
    include(CTest)

endif()

# This module enables populating content at configure time via any method
# supported by the ExternalProject module.
include(FetchContent)

# Formatting library
FetchContent_Declare(
  fmtlib
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 5.3.0)
FetchContent_MakeAvailable(fmtlib)


add_subdirectory(src)

add_subdirectory(lib)


# Testing only available if this is the main app
# if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME) AND BUILD_TESTING)
#     add_subdirectory(tests)
# endif()





