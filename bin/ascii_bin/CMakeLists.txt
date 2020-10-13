cmake_minimum_required(VERSION 2.6)

project("_ascii" LANGUAGES C)

include_directories ("${PROJECT_SOURCE_DIR}/include")
add_subdirectory ("${PROJECT_SOURCE_DIR}/include")
add_executable (_ascii "${PROJECT_SOURCE_DIR}/src/ascii.c")
target_link_libraries (_ascii xconio)
