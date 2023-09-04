# https://kubasejdak.com/how-to-cross-compile-for-embedded-with-cmake-like-a-champ

set(TARGET_TRIPLET              arm-none-eabi        )

set(CMAKE_C_COMPILER            ${TARGET_TRIPLET}-gcc)
set(CMAKE_CXX_COMPILER          ${TARGET_TRIPLET}-g++)

