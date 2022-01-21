#####################################################################
#                 DEFINE MAIN TARGET PROPERTIES                     #
#####################################################################
add_executable(${EXECUTABLE} main.c)

# --- Declare flags: ---
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)
target_include_directories(${EXECUTABLE} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/inc ${PROJECT_SOURCE_DIR}/drivers/CMSIS/Include)


# if (SOME_SETTING)
#     target_compile_definitions(main PUBLIC WITH_SOME_SETTING)
# endif()
# If the setting only affects implementation, use PRIVATE instead

#####################################################################
#                           MODULES                                 #
#####################################################################
add_subdirectory(${PROJECT_SOURCE_DIR}/lib ${PROJECT_BINARY_DIR}/build/lib)
# add_subdirectory(modulo1)
# add_subdirectory(modulo2)


#####################################################################
#                        DEPENDENCIES                               #
#####################################################################
target_link_libraries(${EXECUTABLE} PRIVATE CMSIS)

