#####################################################################
#                           PREAMBLE                                #
#####################################################################
cmake_minimum_required(VERSION 3.22)

# -- TODO: Specify the gcc-arm compiler path and device family and number
set(ARM_TOOLCHAIN_PATH /opt/gcc-arm CACHE STRING "")
set(STM32_FAMILY F7 CACHE STRING "")
set(STM32_DEVICE STM32F769xx CACHE STRING "")

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/STM32-toolchain.cmake)

# -- TODO: Define a name and a description for the project
project(
    stm32-project
    VERSION 0.1
    DESCRIPTION "STM32 Development Skeleton"
    LANGUAGES C CXX ASM
)

# -- TODO: Define a name for the executable
set(EXECUTABLE "exe-name")

#####################################################################
#                       PROJECT WIDE SETUP                          #
#####################################################################
# Add cmake folder to the module path:
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# -- TODO: Define required standards for C and C++
# Language standards specifications (and requirements):
set(CMAKE_C_STANDARD 99 CACHE STRING "")
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)   # Ensure -std=cxx instead of -std=gnuxx

# Global flags declaration (used on all targets):
add_compile_options(-Wall -Werror)

# Build type configuration:
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
include(FetchContent)
set(FETCHCONTENT_QUIET off)

# STM32Cube SDK:
FetchContent_Declare(
  STM32Cube
  GIT_REPOSITORY https://github.com/STMicroelectronics/STM32Cube${STM32_FAMILY}.git
  GIT_TAG        master
  SOURCE_DIR     ${PROJECT_SOURCE_DIR}/lib/STM32Cube
)
FetchContent_MakeAvailable(STM32Cube)

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


