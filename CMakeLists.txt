cmake_minimum_required(VERSION 3.11)
project($(MODULE) C)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
find_package(RAGEL)
