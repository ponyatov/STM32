cmake_minimum_required(VERSION 3.11)
set(CMAKE_TOOLCHAIN_FILE cmake/arm-none-eabi.cmake)
# project(${APP} VERSION 0.0.1 LANGUAGES C CXX)

file(GLOB C RELATIVE ${CMAKE_SOURCE_DIR} "src/*.c*" "tmp/*.c*")
file(GLOB H RELATIVE ${CMAKE_SOURCE_DIR} "inc/*.h*" "tmp/*.h*")

# add_link_options("-Wl,-E") # dl

include_directories(
    "${CMAKE_SOURCE_DIR}/inc"
    "${CMAKE_SOURCE_DIR}/tmp"
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_executable(${APP}
    ${C} ${H}
    # ${FLEX_lexer_OUTPUTS} ${BISON_parser_OUTPUTS}
)
