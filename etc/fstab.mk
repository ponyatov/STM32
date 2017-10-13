# add ramdisk for build process
UID = $(shell id -un $(USER))
GID = $(shell id -un $(USER))
etc/fstab: etc/fstab.mk
	echo "tmpfs	/home/$(USER)/src	tmpfs	auto,uid=$(UID),gid=$(GID)	0	0" > $@
	echo "tmpfs	/home/$(USER)/tmp	tmpfs	auto,uid=$(UID),gid=$(GID)	0	0" >> $@
