# rule
bin/$(MODULE): $(C) $(H) $(CP) $(HP)
	$(TCC) $(TFLAGS) -o $@ $(C) $(CP)

$(TMP)/%.lexer.c: $(SRC)/%.lex
	flex -o $@ $<
$(TMP)/%.parser.c: $(SRC)/%.yacc
	bison -o $@ $<
