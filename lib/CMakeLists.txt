string(TOLOWER ${STM32_FAMILY} STM32_FAMILY_L)
string(TOLOWER ${STM32_DEVICE} STM32_DEVICE_L)

#####################################################################
#                            CMSIS                                  #
#####################################################################
option(USE_CMSIS "Enable/Disable CMSIS" ON)

if(USE_CMSIS)
    add_library(
        CMSIS
        STATIC STM32Cube/Drivers/CMSIS/Device/ST/STM32${STM32_FAMILY}xx/Source/Templates/gcc/startup_${STM32_DEVICE_L}.s
               STM32Cube/Drivers/CMSIS//Device/ST/STM32${STM32_FAMILY}xx/Source/Templates/system_stm32${STM32_FAMILY_L}xx.c
    )
    target_include_directories(
        CMSIS
        PUBLIC  STM32Cube/Drivers/CMSIS/Include
                STM32Cube/Drivers/CMSIS/Device/ST/STM32${STM32_FAMILY}xx/Include
    )
endif()

#####################################################################
#                             HAL                                   #
#####################################################################
option(USE_HAL "Enable/Disable HAL" ON)

if(USE_HAL)
    set(HAL_SRC_PATH ${PROJECT_SOURCE_DIR}/lib/STM32Cube/Drivers/STM32${STM32_FAMILY}xx_HAL_Driver/Src PARENT_SCOPE)
    add_library(HAL STATIC)
    target_include_directories(
        CMSIS
        PUBLIC  STM32Cube/Drivers/STM32${STM32_FAMILY}xx_HAL_Driver/Inc
    )
    target_compile_definitions(CMSIS PUBLIC USE_HAL_DRIVER)
    target_link_libraries(HAL PUBLIC CMSIS)
endif()

#####################################################################
#                             BSP                                   #
#####################################################################
option(USE_BSP "Enable/Disable BSP" ON)

if(USE_BSP)
    set(BSP_SRC_PATH ${PROJECT_SOURCE_DIR}/lib/STM32Cube/Drivers/BSP/${STM32_BOARD} PARENT_SCOPE)
    add_library(BSP STATIC)
    target_include_directories(
        BSP
        PUBLIC  STM32Cube/Drivers/BSP/${STM32_BOARD}
                STM32Cube/Drivers/BSP/${STM32_BOARD}/../Components
    )
    target_link_libraries(BSP PUBLIC HAL)
endif()