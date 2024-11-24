# src
C += $(wildcard $(SRC)/*.c*)
H += $(wildcard $(INC)/*.h*)
J += $(wildcard $(LIB)/*.js) $(wildcard $(TMP)/*.js)
F += $(wildcard $(LIB)/*.ini) $(wildcard $(LIB)/*.f)

# CP += $(TMP)/$(MODULE).parser.cpp $(TMP)/$(MODULE).lexer.cpp
# HP += $(TMP)/$(MODULE).parser.hpp

OBJ += $(TMP)/vm.o $(TMP)/compiler.o $(TMP)/microrl.o
