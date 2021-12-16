add_executable(main main.c)

#  target_sources(main PRIVATE src1.c src2.c)

target_include_directories(main PRIVATE ../include)

target_link_libraries(main PRIVATE mylib)

