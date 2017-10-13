CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
TMP = $(CWD)/tmp

CMAKE_VER = 3.9.4
CMAKE_DIR = cmake-$(CMAKE_VER)
CMAKE_GZ = $(CMAKE_DIR).tar.gz
CMAKE_URL = https://cmake.org/files/v3.9/$(CMAKE_GZ)

CMAKE = $(CWD)/tools/bin/cmake

.PHONY: all
all: stlink/README.md $(CMAKE)

.PHONY: ramdisk
ramdisk: /home/$(USER)/src /home/$(USER)/tmp etc/fstab
	sudo sh etc/fstab.rc
etc/fstab: etc/fstab.mk
	$(MAKE) -f $< && touch $@

$(CMAKE): $(SRC)/$(CMAKE_DIR)/configure
	rm -rf $(TMP)/$(CMAKE_DIR) ; mkdir $(TMP)/$(CMAKE_DIR) ; cd $(TMP)/$(CMAKE_DIR) ;\
	$< --help

# source unpack rules
$(SRC)/%/configure: $(GZ)/%.tar.gz
	cd src ; tar zx < $< && touch $@

WGET = wget -c
$(GZ)/$(CMAKE_GZ):
	$(WGET) -O $@ $(CMAKE_URL)

stlink/README.md:
	git clone -o gh --depth=1 https://github.com/texane/stlink.git
