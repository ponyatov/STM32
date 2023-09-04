# version
STLINK_VER = 1.7.0

# dir
GZ = $(HOME)/gz

# tool
CURL   = curl -L -o
CF     = clang-format
STINFO = /usr/bin/st-info

# src
C += $(wildcard src/*.c??)

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
install: gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt apt.dev`

STLINK_DEB = stlink_$(STLINK_VER)-1_amd64.deb

.PHONY: gz
gz: $(STINFO)

$(STINFO):
	$(MAKE) $(GZ)/$(STLINK_DEB)
	sudo dpkg -i $<

$(GZ)/$(STLINK_DEB):
	$(CURL) $@ https://github.com/stlink-org/stlink/releases/download/v$(STLINK_VER)/$(STLINK_DEB)
