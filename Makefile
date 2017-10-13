CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
TMP = $(CWD)/tmp
TOOL = $(CWD)/tools

CORES = $(shell grep processor /proc/cpuinfo|wc -l) 

CMAKE_VER = 3.9.4
CMAKE_DIR = cmake-$(CMAKE_VER)
CMAKE_GZ = $(CMAKE_DIR).tar.gz
CMAKE_URL = https://cmake.org/files/v3.9/$(CMAKE_GZ)

LIBUSB_VER = 1.0.21
LIBUSB_DIR = libusb-$(LIBUSB_VER)
LIBUSB_GZ = $(LIBUSB_DIR).tar.bz2
LIBUSB_URL = https://downloads.sourceforge.net/project/libusb/libusb-1.0/$(LIBUSB_DIR)/$(LIBUSB_GZ)

STLINK_VER = 1.4.0
STLINK_URL = https://github.com/texane/stlink/archive/$(STLINK_VER) .tar.gz

CMAKE = $(TOOL)/bin/cmake
# system
#CMAKE = /usr/bin/cmake

XPATH = PATH=$(TOOL)/bin:$(PATH)

WGET = wget -c

.PHONY: udev
udev: /etc/udev/rules.d/49-stlink.rules
/etc/udev/rules.d/49-stlink.rules: $(CWD)/etc/udev/rules.d/49-stlink.rules
ifeq ($(shell egrep -q "^stlink:" /etc/group),0)
	sudo addgroup stlink
endif
	sudo cp $< $@
	sudo /etc/init.d/udev reload
	ls /dev/stlink* /dev/sdb ; mount

.PHONY: all
all: packs stlink/README.md $(TOOL)/include/libusb-1.0/libusb.h
	cd stlink ; $(XPATH) CC=gcc CXX=g++ $(MAKE) CMAKEFLAGS="LIBUSB_LIBRARY=$(TOOL)/lib LIBUSB_INCLUDE_DIR=$(TOOL)/include" clean release
#	$(CMAKE) --version
#	cd stlink ; $(XPATH) CC=clang CXX=clang++ $(MAKE) clean release
	
.PHONY: packs
packs: /usr/include/libusb-1.0/libusb.h /usr/include/libudev.h \
	/usr/bin/make /usr/bin/clang /usr/bin/clang++ $(CMAKE)
/usr/include/libusb-1.0/libusb.h:
	sudo apt install libusb-1.0-0-dev
/usr/bin/make:
	sudo apt install make
/usr/bin/cmake:
	sudo apt install cmake
/usr/bin/gcc:
	sudo apt install gcc
/usr/bin/g++:
	sudo apt install g++
/usr/bin/clang /usr/bin/clang++:
	sudo apt install clang
/usr/include/libudev.h:
	sudo apt install libudev-dev

.PHONY: ramdisk
ramdisk: /home/$(USER)/src /home/$(USER)/tmp etc/fstab
	sudo sh etc/fstab.rc
etc/fstab: etc/fstab.mk
	$(MAKE) -f $< && touch $@

$(TOOL)/bin/cmake: $(SRC)/$(CMAKE_DIR)/configure
	rm -rf $(TMP)/$(CMAKE_DIR) ; mkdir $(TMP)/$(CMAKE_DIR) ; cd $(TMP)/$(CMAKE_DIR) ;\
	$< --prefix=$(TOOL) --parallel=$(CORES) && $(MAKE) -j$(CORES) && $(MAKE) install

$(TOOL)/include/libusb-1.0/libusb.h: $(SRC)/$(LIBUSB_DIR)/configure /usr/include/libudev.h
	rm -rf $(TMP)/$(LIBUSB_DIR) ; mkdir $(TMP)/$(LIBUSB_DIR) ; cd $(TMP)/$(LIBUSB_DIR) ;\
	$< --prefix=$(TOOL) && $(MAKE) -j$(CORES) && $(MAKE) install 

# source unpack rules
$(SRC)/%/configure: $(GZ)/%.tar.gz
	cd src ; tar zx < $< && touch $@
$(SRC)/%/configure: $(GZ)/%.tar.bz2
	cd src ; bzcat $< | tar x && touch $@

$(GZ)/$(CMAKE_GZ):
	$(WGET) -O $@ $(CMAKE_URL)
$(GZ)/$(LIBUSB_GZ):
	$(WGET) -O $@ $(LIBUSB_URL)

stlink/README.md:
	git clone -o gh --depth=1 https://github.com/texane/stlink.git
