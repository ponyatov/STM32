CWD = $(CURDIR)
GZ = $(CWD)/gz

CMAKE_VER = 3.9.4
CMAKE_GZ = cmake-$(CMAKE_VER).tar.gz
CMAKE_URL = https://cmake.org/files/v3.9/$(CMAKE_GZ)

.PHONY: all
all: stlink/README.md $(GZ)/$(CMAKE_GZ)

WGET = wget -c
$(GZ)/$(CMAKE_GZ):
	$(WGET) -O $@ $(CMAKE_URL)

stlink/README.md:
	git clone -o gh --depth=1 https://github.com/texane/stlink.git
