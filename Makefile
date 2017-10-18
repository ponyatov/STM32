GID = $(shell id -gn)
UID = $(shell id -un)

CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
TMP = $(CWD)/tmp
TOOL = $(CWD)/tools
MBED = $(CWD)/mbed

CORES = $(shell grep processor /proc/cpuinfo|wc -l) 

LIBUSB_VER = 1.0.21
LIBUSB_DIR = libusb-$(LIBUSB_VER)
LIBUSB_GZ = $(LIBUSB_DIR).tar.bz2
LIBUSB_URL = https://downloads.sourceforge.net/project/libusb/libusb-1.0/$(LIBUSB_DIR)/$(LIBUSB_GZ)

STLINK_TAG = 1.4.0
STLINK_GITHUB = git@github.com:ponyatov/stlink.git
STLINK_BRANCH = ponyatov_140

STLINK = LD_LIBRARY_PATH=$(TOOL)/lib $(TOOL)/bin/st-util

CMAKE_VER = 3.9.4
CMAKE_DIR = cmake-$(CMAKE_VER)
CMAKE_GZ = $(CMAKE_DIR).tar.gz
CMAKE_URL = https://cmake.org/files/v3.9/$(CMAKE_GZ)

CMAKE = $(TOOL)/bin/cmake
# system
CMAKE = /usr/bin/cmake

XPATH = PATH=$(TOOL)/bin:$(PATH)

WGET = wget -c

.PHONY: all
all: stlink

.PHONY: stlink
stlink: $(TOOL)/bin/st-util /etc/modprobe.d/stlink_v1.conf
	$(STLINK)
etc/modprobe.d/stlink_v1.conf: $(TMP)/etc/modprobe.d/stlink_v1.conf
	cp $< $@	
/etc/modprobe.d/stlink_v1.conf: etc/modprobe.d/stlink_v1.conf
	sudo cp $< $@
STLINK_CFG = -DCMAKE_INSTALL_PREFIX=/stlink
#STLINK_CFG += -DBUILD_SHARED_LIBRARIES=OFF
#STLINK_CFG += -DCMAKE_EXE_LINKER_FLAGS=-static
$(TOOL)/bin/st-util: stlink/README_ponyatov.md /usr/include/libusb-1.0/libusb.h
	cd stlink ; $(MAKE) clean ;\
	$(MAKE) DESTDIR=$(TMP) CMAKEFLAGS="$(STLINK_CFG)" install &&\
	cp -r $(TMP)/stlink/* $(TOOL)/ 
stlink/README_ponyatov.md: stlink/README.md
	cd stlink ; git checkout $(STLINK_BRANCH)
stlink/README.md:
	git clone -o gh $(STLINK_GITHUB)

.PHONY: udev
udev: /etc/udev/rules.d/49-STlink.rules /etc/udev/rules.d/49-FRDM.rules
/etc/udev/rules.d/49-FRDM.rules: $(CWD)/etc/udev/rules.d/49-FRDM.rules
	sudo cp $< $@ ; sudo /etc/init.d/udev reload
/etc/udev/rules.d/49-STlink.rules: $(CWD)/etc/udev/rules.d/49-STlink.rules
ifeq ($(shell egrep -q "^stlink:" /etc/group),0)
	sudo addgroup stlink
	sudo adduser $(USER) stlink
endif
	sudo sed "s/_MBED/$(subst /,\/,$(MBED))/g ; s/_USER/$(USER)/g; w $@" $<
	sudo /etc/init.d/udev reload
	ls /dev/stlink* /dev/sdb ; mount
	
#.PHONY: all
#all: packs $(TOOL)/include/libusb-1.0/libusb.h
#	cd stlink ; $(XPATH) CC=gcc CXX=g++ $(MAKE) CMAKEFLAGS="LIBUSB_LIBRARY=$(TOOL)/lib LIBUSB_INCLUDE_DIR=$(TOOL)/include" clean release
##	$(CMAKE) --version
##	cd stlink ; $(XPATH) CC=clang CXX=clang++ $(MAKE) clean release
	
.PHONY: packs
packs: /usr/bin/make $(CMAKE)
#/usr/include/libusb-1.0/libusb.h /usr/include/libudev.h
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
/usr/include/libudev.h:
	sudo apt install libudev-dev

.PHONY: ramdisk
ramdisk: etc/fstab $(SRC) $(TMP) 
	sudo $(MAKE) /etc/fstab
/etc/fstab: etc/fstab Makefile
	sed "s/_SRC/$(subst /,\/,$(SRC))/g ; s/_TMP/$(subst /,\/,$(TMP))/g ; s/_UID/$(UID)/g ; s/_GID/$(GID)/g " $< >> $@
	vim $@
	mount -a 

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

#$(GZ)/$(STLINK_GZ):
#	$(WGET) -O $@ $(STLINK_URL)
$(GZ)/$(CMAKE_GZ):
	$(WGET) -O $@ $(CMAKE_URL)
$(GZ)/$(LIBUSB_GZ):
	$(WGET) -O $@ $(LIBUSB_URL)
