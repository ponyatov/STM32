TARGET = arm-none-eabi
APT   += gcc-$(TARGET) gdb-multiarch stlink-tools dfu-util qemu-system-arm
OS    ?= _

# tool: CubeMX binary path
CUBEMX ?= $(HOME)/STM32/CubeMX/STM32CubeMX

# run make cubemx
.PHONY: cubemx
cubemx: $(CUBEMX)
	$<

# CubeMX automated install
CUBE_SDIR  = $(TMP)/cubemx
CUBE_SETUP = SetupSTM32CubeMX-$(CUBEMX_VER)

$(CUBEMX):
	$(MAKE) $(CUBE_SDIR)/$(CUBE_SETUP)
	$(CUBE_SDIR)/$(CUBE_SETUP)

$(CUBE_SDIR)/$(CUBE_SETUP): $(DISTR)/$(CUBEMX_GZ)
	unzip -d $(CUBE_SDIR) $< && touch $@

GZ += $(DISTR)/$(CUBEMX_GZ)
$(DISTR)/$(CUBEMX_GZ):
	$(CURL) $@ $(CUBEMX_URL)/$(subst .,-,$(CUBEMX_GZ))
