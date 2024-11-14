# cross
HWINFO = tmp/hw.info

ifeq (,$(wildcard $(HWINFO)))
.PHONY: hwinfo
hwinfo: $(HWINFO)
$(HWINFO):
	echo "STVER  ?= $(shell st-info --version)"  > $@
	echo "FLASH  ?= $(shell st-info --flash  )" >> $@
	echo "SRAM   ?= $(shell st-info --sram   )" >> $@
	echo "SERIAL ?= $(shell st-info --serial )" >> $@
	echo "CHIPID ?= $(shell st-info --chipid )" >> $@
	echo "DESCR  ?= $(shell st-info --descr  )" >> $@
endif

include      $(HWINFO)
include   hw/$(DESCR)_$(CHIPID).mk
include   hw/$(HW).mk
include  cpu/$(CPU).mk
include arch/$(ARCH).mk

# cross-compiler
TCC   = $(TARGET)-gcc
TXX   = $(TARGET)-g++
TDUMP = $(TARGET)-objdump
TSIZE = $(TARGET)-size
TCOPY = $(TARGET)-objcopy
