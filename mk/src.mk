# src
C += $(wildcard $(SRC)/*.c*)
H += $(wildcard $(INC)/*.h*)
F += $(wildcard $(LIB)/*.ini) $(wildcard $(LIB)/*.f)

CP += $(patsubst $(SRC)/%.lex,$(TMP)/%.lexer.c,$(wildcard $(SRC)/*.lex))
CP += $(patsubst $(SRC)/%.yacc,$(TMP)/%.parser.c,$(wildcard $(SRC)/*.yacc))
HP += $(patsubst $(SRC)/%.yacc,$(TMP)/%.parser.h,$(wildcard $(SRC)/*.yacc))
