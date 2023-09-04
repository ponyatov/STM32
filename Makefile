
# all
.PHONY: all
all:

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) --style=file -i $? && touch $@

# install
.PHONY: install update
install update:
	sudo apt update
	sudo apt install -yu `cat apt.txt apt.dev`
