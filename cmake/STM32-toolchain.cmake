set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

if(NOT ARM_TOOLCHAIN_PATH)
    message(ERROR "You have to specify a path to the GCC-ARM folder in your system!")
endif()
set(ARM_TARGET_TRIPLET "arm-none-eabi")

set(TOOLCHAIN_SYSROOT  "${ARM_TOOLCHAIN_PATH}/${ARM_TARGET_TRIPLET}")
set(TOOLCHAIN_BIN_PATH "${ARM_TOOLCHAIN_PATH}/bin")
set(TOOLCHAIN_INC_PATH "${ARM_TOOLCHAIN_PATH}/${ARM_TARGET_TRIPLET}/include")
set(TOOLCHAIN_LIB_PATH "${ARM_TOOLCHAIN_PATH}/${ARM_TARGET_TRIPLET}/lib")

find_program(CMAKE_C_COMPILER NAMES ${ARM_TARGET_TRIPLET}-gcc HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_CXX_COMPILER NAMES ${ARM_TARGET_TRIPLET}-g++ HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_ASM_COMPILER NAMES ${ARM_TARGET_TRIPLET}-gcc HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_OBJCOPY NAMES ${ARM_TARGET_TRIPLET}-objcopy HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_OBJDUMP NAMES ${ARM_TARGET_TRIPLET}-objdump HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_SIZE NAMES ${ARM_TARGET_TRIPLET}-size HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_DEBUGGER NAMES ${ARM_TARGET_TRIPLET}-gdb HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_CPPFILT NAMES ${ARM_TARGET_TRIPLET}-c++filt HINTS ${TOOLCHAIN_BIN_PATH})

if("${STM32_FAMILY}" STREQUAL "F7")
    set(ARM_OPTIONS -mcpu=cortex-m7 -mfpu=auto -mfloat-abi=hard --specs=nano.specs)
else()
    message(ERROR "No family specified!")
endif()

add_compile_options(
    ${ARM_OPTIONS}
    -funsigned-char
    -ffunction-sections
    -fdata-sections
)

add_compile_definitions(
    ${STM32_DEVICE}
)

add_link_options(
    ${ARM_OPTIONS}
    # $<$<CONFIG:DEBUG>:--specs=rdimon.specs>
    # $<$<CONFIG:RELEASE>:--specs=nosys.specs>
    # $<$<CONFIG:DEBUG>:-u_printf_float>
    # $<$<CONFIG:DEBUG>:-u_scanf_float>
    -nostartfiles
    LINKER:--gc-sections
    LINKER:--build-id
)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_EXECUTABLE_SUFFIX_C   .elf)
set(CMAKE_EXECUTABLE_SUFFIX_CXX .elf)
set(CMAKE_EXECUTABLE_SUFFIX_ASM .elf)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
