# https://kubasejdak.com/how-to-cross-compile-for-embedded-with-cmake-like-a-champ

set(TARGET_TRIPLET              arm-none-eabi            )

set(CMAKE_C_COMPILER            ${TARGET_TRIPLET}-gcc    )
set(CMAKE_CXX_COMPILER          ${TARGET_TRIPLET}-g++    )
set(CMAKE_ASM_COMPILER          ${TARGET_TRIPLET}-as     )
set(CMAKE_LINKER                ${TARGET_TRIPLET}-ld     )

set(CMAKE_AR                    ${TARGET_TRIPLET}-ar     )
set(CMAKE_OBJCOPY               ${TARGET_TRIPLET}-objcopy)
set(CMAKE_RANLIB                ${TARGET_TRIPLET}-ranlib )
set(CMAKE_SIZE                  ${TARGET_TRIPLET}-size   )
set(CMAKE_STRIP                 ${TARGET_TRIPLET}-strip  )
