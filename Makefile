APP ?= ir
# HW  ?= BluePillF030
HW  ?= qemu

include   hw/$(HW).mk
include  cpu/$(CPU).mk
include arch/$(ARCH).mk
include  app/$(APP).mk

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
all: bin/$(APP).bin

.PHONY: qemu
qemu: bin/none
	qemu-system-arm -M -kernel $<

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) --style=file -i $? && touch $@

CXX     = $(TRIPLET)-g++
OBJCOPY = $(TRIPLET)-objcopy

CFLAGS += -Iinc -Itmp
CFLAGS += -nostartfiles -nostdlib

.PHONY: swd
swd:
	st-util

# rule
bin/%.bin: bin/%.elf
	$(OBJCOPY) -S -O binary $< $@
# tmp/%.elf: src/%.c?? src/lib.cpp
# 	$(CXX) $(CFLAGS) -nostdlib -o $@ $^
bin/$(APP).elf: \
				src/$(APP).cpp src/$(HW).cpp src/$(CPU).cpp src/$(CPU).s \
				src/$(ARCH).cpp src/lib.cpp
	$(CXX) $(CFLAGS) -o $@ $^ && file $@

# install
.PHONY: install update
install: gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt apt.dev`

STLINK_DEB = stlink_$(STLINK_VER)-1_amd64.deb

.PHONY: gz
gz: $(STINFO) src/stm32f030f4p6.s

$(STINFO): $(GZ)/$(STLINK_DEB)
	sudo dpkg -i $< && sudo touch $@

$(GZ)/$(STLINK_DEB):
	$(CURL) $@ https://github.com/stlink-org/stlink/releases/download/v$(STLINK_VER)/$(STLINK_DEB)

src/stm32f030f4p6.s: tmp/STM32-startup/STM32F0/stm32f030x6.s
	cp $< $@
src/lm3s6965.s: tmp/STM32-startup/qemu-cortex-m3.s
	cp $< $@
tmp/STM32-startup/STM32F0/stm32f030x6.s:
	git clone --depth=1 https://github.com/hwengineer/STM32-startup.git tmp/STM32-startup
