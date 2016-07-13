#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# make uImage and dtb
define Image/uImage-dtb
	gzip -9c < $(KDIR)/Image > $(KDIR)/Image.gz
	$(eval ARCH_BACK = $(ARCH))
	$(eval ARCH = $(LINUX_KARCH))
	$(call Image/BuildKernel/MkuImage, gzip, $(KERNEL_LOADADDR), \
		$(KERNEL_ENTRY_POINT), $(KDIR)/Image.gz, \
		$(KDIR)/$(IMG_PREFIX)-uImage)
	$(eval ARCH = $(ARCH_BACK))

	$(call Image/BuildDTB,$(DTS_DIR)/$(DEVICE_DTS).dts,$(KDIR)/$(IMG_PREFIX)-dtb)
endef

# $(1) source image name
# $(2) partition image name
# $(3) partition image size(M)
define Image/Build/flashpartitionimage
	./checkimagesize.sh $(1) $(3)
	dd if=/dev/zero bs=1M count=$(3) | sed 's/\x00/\xff/g' > $(2)
	dd if=$(1) of=$(2) conv=notrunc
endef

# make squashfs then merge uImage/dtb/squashfs to one firmware image arranged
# by individual partition
define Image/Build/squashfs
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)

	$(call Image/Build/flashpartitionimage,$(KDIR)/$(IMG_PREFIX)-dtb,$(KDIR)/$(IMG_PREFIX)-dtb-par,$(DTB_PARTITION_SIZE))
	$(call Image/Build/flashpartitionimage,$(KDIR)/$(IMG_PREFIX)-uImage,$(KDIR)/$(IMG_PREFIX)-uImage-par,$(KERNEL_PARTITION_SIZE))
	$(call Image/Build/flashpartitionimage,$(KDIR)/root.squashfs,$(KDIR)/root.squashfs-par,$(SQUASHFS_PARTITION_SIZE))
	cat $(KDIR)/$(IMG_PREFIX)-dtb-par $(KDIR)/$(IMG_PREFIX)-uImage-par \
		$(KDIR)/root.squashfs-par > $(BIN_DIR)/$(IMG_PREFIX)-firmware
	$(RM) $(KDIR)/$(IMG_PREFIX)-dtb-par $(KDIR)/$(IMG_PREFIX)-uImage-par \
		$(KDIR)/root.squashfs-par
endef

# target macros
define Target/Default
	KERNEL_LOADADDR = 0x80080000
	KERNEL_ENTRY_POINT = 0x80080000
endef

# callback function: Image/BuildKernel
define Image/BuildKernel
	$(eval $(call Target/Default))
	$(eval $(call Subtarget/Default))
	$(call Image/uImage-dtb)
endef

# callback function: Image/Build
define Image/Build
	$(call Image/Build/$(1),$(1))
endef

$(eval $(call BuildImage))
