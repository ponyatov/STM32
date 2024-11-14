# Linux host & embedded target

## flex/bison parser

CP += $(patsubst $(SRC)/%.lex,$(TMP)/%.lexer.c,$(wildcard $(SRC)/*.lex))
CP += $(patsubst $(SRC)/%.yacc,$(TMP)/%.parser.c,$(wildcard $(SRC)/*.yacc))
HP += $(patsubst $(SRC)/%.yacc,$(TMP)/%.parser.h,$(wildcard $(SRC)/*.yacc))

OBJ += $(patsubst %.c,%.o,$(CP))
