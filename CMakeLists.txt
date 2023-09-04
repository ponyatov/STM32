cmake_minimum_required(VERSION 3.11)
set(CMAKE_TOOLCHAIN_FILE cmake/arm-none-eabi.cmake)
project(${APP} VERSION 0.0.1 LANGUAGES C CXX)

# list(append C src/none.cpp)
# add_executable(${APP} ${C})
