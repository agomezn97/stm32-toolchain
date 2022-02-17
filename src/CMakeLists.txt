#####################################################################
#                 DEFINE MAIN TARGET PROPERTIES                     #
#####################################################################
add_executable(${EXECUTABLE} main.c)

# --- Declare flags: ---
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)
target_include_directories(${EXECUTABLE} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/inc)
set_target_properties(${EXECUTABLE} PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})


# if (SOME_SETTING)
#     target_compile_definitions(main PUBLIC WITH_SOME_SETTING)
# endif()
# If the setting only affects implementation, use PRIVATE instead

#####################################################################
#                           MODULES                                 #
#####################################################################
add_subdirectory(${PROJECT_SOURCE_DIR}/lib ${PROJECT_BINARY_DIR}/build/lib)
# add_subdirectory(module1)
# add_subdirectory(module2)

target_sources(
    HAL
    PUBLIC  ${HAL_SRC_PATH}/stm32f7xx_hal.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_cortex.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_gpio.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_uart.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_i2c.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_pwr_ex.c
            ${HAL_SRC_PATH}/stm32f7xx_hal_rcc.c
)
target_sources(
    BSP
    PUBLIC  ${BSP_SRC_PATH}/stm32f769i_discovery.c
)


#####################################################################
#                        DEPENDENCIES                               #
#####################################################################
# The dependencies in STM32Cube are: BSP --> ( HAL --> CMSIS )
# If you link against BSP there is no need to link against HAL or CMSIS
target_link_libraries(${EXECUTABLE} PRIVATE BSP)
target_link_options(${EXECUTABLE} PRIVATE -T ${LINKER_SCRIPT})

