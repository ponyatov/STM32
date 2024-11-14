.PHONY: all run
all: bin/$(MODULE) $(F)
run: bin/$(MODULE) $(F)
	$^
