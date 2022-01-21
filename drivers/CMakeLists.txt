#####################################################################
#                            CMSIS                                  #
#####################################################################
add_library(CMSIS STATIC CMSIS/Source/startup_stm32f769xx.s CMSIS/Source/system_stm32f7xx.c)

target_include_directories(CMSIS PUBLIC CMSIS/Include)