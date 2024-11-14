# rule

OBJ += $(patsubst $(SRC)/%.c,$(TMP)/%.o,$(C))

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

# readline
.PHONY: microrl
microrl: $(SRC)/microrl.c $(INC)/microrl.h $(INC)/config.h
$(SRC)/%.c: $(REF)/microrl/src/%.c $(INC)/%.h $(INC)/config.h
	cp $< $@
$(INC)/%.h: $(REF)/microrl/src/%.h
	cp $< $@
