# src
C += $(wildcard $(SRC)/*.c*)
H += $(wildcard $(INC)/*.h*)
F += $(wildcard $(LIB)/*.ini) $(wildcard $(LIB)/*.f)

OBJ += $(TMP)/microrl.o
