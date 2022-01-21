#####################################################################
#                           PREAMBLE                                #
#####################################################################
cmake_minimum_required(VERSION 3.22)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/stm32_gcc.cmake)

project(
    stm32f7disco-project
    VERSION 0.1
    DESCRIPTION "STM32F769NI-Discovery Development Skeleton"
    LANGUAGES C ASM
)

set(EXECUTABLE "blinky")

#####################################################################
#                       PROJECT WIDE SETUP                          #
#####################################################################
# Declare global flags (used on all targets):
add_compile_options(-Wall -Werror)

# Add cmake folder to the module path:
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Specify and require the C99 standard and ensure -std=cxx instead of -std=gnuxx
set(CMAKE_C_STANDARD 99 CACHE STRING "The C standard to use")
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(default_build_type "Release")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

#####################################################################
#                    EXTERNAL PROVIDED CONTENT                      #
#####################################################################
# # This module enables populating content at configure time via any method
# # supported by the ExternalProject module.
# include(FetchContent)
# set(FETCHCONTENT_QUIET off)

# # STM32CubeF7 SDK:
# FetchContent_Declare(
#   STM32CubeF7
#   GIT_REPOSITORY https://github.com/STMicroelectronics/STM32CubeF7.git
#   GIT_TAG v1.16.2
# )

# FetchContent_MakeAvailable(STM32CubeF7)

#####################################################################
#                MAIN TARGETS BUILT BY THIS PROJECT                 #
#####################################################################
add_subdirectory(src)

find_package(Doxygen)
if(Doxygen_FOUND)
    add_subdirectory(doc)
else()
    message(STATUS "Doxygen not found, not building docs")
endif()

#####################################################################
#                            TESTING                                #
#####################################################################
# include(CTest)
# if(BUILD_TESTING)
#     add_subdirectory(tests)
# endif()

#####################################################################
#                           PACKAGING                               #
#####################################################################


