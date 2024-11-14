# rule
bin/$(MODULE): $(C) $(H) $(CP) $(HP)
	$(TCC) $(TFLAGS) -o $@ $(C) $(CP)
