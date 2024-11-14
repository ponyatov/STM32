# rule

OBJ += $(patsubst %.c,%.o,$(C))

bin/$(MODULE): $(OBJ)
	$(TCC) $(TFLAGS) -o $@ $^ $(L)

$(TMP)/%.o: $(TMP)/%.c $(H)
	$(TCC) $(TFLAGS) -o $@ -c $<
$(TMP)/%.o: $(SRC)/%.c $(H)
	$(TCC) $(TFLAGS) -o $@ -c $<

ifeq ($(OS),Linux)
$(TMP)/%.lexer.c: $(SRC)/%.lex
	flex -o $@ $<
$(TMP)/%.parser.c: $(SRC)/%.yacc
	bison -o $@ $<
endif
