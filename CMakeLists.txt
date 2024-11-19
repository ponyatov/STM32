cmake_minimum_required(VERSION 3.22)
get_filename_component(PROJECT_NAME ${CMAKE_SOURCE_DIR} NAME_WE)
project(${PROJECT_NAME} LANGUAGES C CXX ASM)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CWD ${CMAKE_SOURCE_DIR})
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CWD}/cmake)
set(INC ${CWD}/inc)
set(SRC ${CWD}/src)
set(TMP ${CWD}/tmp)

file(GLOB_RECURSE A
    "${CWD}/hw/${HW}/*.s"
)
file(GLOB_RECURSE C
    "${SRC}/*.c*"
    "${CWD}/hw/${HW}/Core/Src/*.c*"
    "${CWD}/hw/${HW}/Drivers/STM32F4xx_HAL_Driver/Src/*.c*"
)
file(GLOB_RECURSE H
    "${INC}/*.h*"
    "${CWD}/hw/${HW}/Core/Inc/*.h*"
    "${CWD}/hw/${HW}/Drivers/CMSIS/Include/*.h*"
    "${CWD}/hw/${HW}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/*.h*"
    "${CWD}/hw/${HW}/Drivers/STM32F4xx_HAL_Driver/Inc/*.h*"
)

include_directories(
    ${INC} ${TMP}
    "${CWD}/hw/${HW}/Core/Inc"
    "${CWD}/hw/${HW}/Drivers/CMSIS/Include"
    "${CWD}/hw/${HW}/Drivers/CMSIS/Device/ST/STM32F4xx/Include"
    "${CWD}/hw/${HW}/Drivers/STM32F4xx_HAL_Driver/Inc"
)

add_compile_definitions(
# ${CMAKE_PROJECT_NAME} INTERFACE
	USE_FULL_LL_DRIVER
	HSE_VALUE=25000000
	HSE_STARTUP_TIMEOUT=100
	LSE_STARTUP_TIMEOUT=5000
	LSE_VALUE=32768
	EXTERNAL_CLOCK_VALUE=12288000
	HSI_VALUE=16000000
	LSI_VALUE=32000
	VDD_VALUE=3300
	PREFETCH_ENABLE=1
	INSTRUCTION_CACHE_ENABLE=1
	DATA_CACHE_ENABLE=1
	STM32F407xx
    $<$<CONFIG:Debug>:DEBUG>
)

find_package(RAGEL REQUIRED)
find_package(FLEX  REQUIRED)
find_package(BISON REQUIRED)

# add_definitions(-DISK)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

file(GLOB L CONFIGURE_DEPENDS ${SRC}/*.lex)
file(GLOB Y CONFIGURE_DEPENDS ${SRC}/*.yacc)
get_filename_component(lex  ${L} NAME_WE)
get_filename_component(yacc ${Y} NAME_WE)
message(L=${L})
message(Y=${Y})
 FLEX_TARGET(lex  ${L} ${TMP}/${lex}.lexer.c)
BISON_TARGET(yacc ${Y} ${TMP}/${yacc}.parser.c)

add_library(parser STATIC ${FLEX_lex_OUTPUTS} ${BISON_yacc_OUTPUTS})

message("-- toolchain: " ${CMAKE_TOOLCHAIN_FILE})
message("--   startup: " ${A})
add_executable(${CMAKE_PROJECT_NAME} ${C} ${H} ${A})
target_link_libraries(${PROJECT_NAME} parser)
