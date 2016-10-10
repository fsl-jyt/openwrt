#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

define Build/mk_firmware
	$(call Image/BuildDTB,$(DTS_DIR)/$(word 1,$(1)).dts,$(KDIR)/$(IMAGE_PREFIX).dtb)
	dd if=/dev/zero bs=$(word 2,$(1)) count=1 | sed 's/\x00/\xff/g' > $(KDIR)/$(IMAGE_PREFIX).dtb.par
	dd if=$(KDIR)/$(IMAGE_PREFIX).dtb of=$(KDIR)/$(IMAGE_PREFIX).dtb.par conv=notrunc

	dd if=/dev/zero bs=$(word 3,$(1)) count=1 | sed 's/\x00/\xff/g' > $(KDIR)/$(KERNEL_IMAGE).par
	dd if=$(KDIR)/$(KERNEL_IMAGE) of=$(KDIR)/$(KERNEL_IMAGE).par conv=notrunc

	dd if=/dev/zero bs=$(word 4,$(1)) count=1 | sed 's/\x00/\xff/g' > $(KDIR)/root.squashfs.par
	dd if=$(KDIR)/root.squashfs of=$(KDIR)/root.squashfs.par conv=notrunc

	cat $(KDIR)/$(IMAGE_PREFIX).dtb.par $(KDIR)/$(KERNEL_IMAGE).par $(KDIR)/root.squashfs.par > $@

	if [[ "$(PROFILE)" == ls1012ardb* ]]; then \
		$(STAGING_DIR_HOST)/bin/make_ext4fs -l $(word 4,$(1)) -b 4096 -i 6000 -m 0 -J $(KDIR)/$(PROFILE).root.ext4 $(TARGET_DIR) ; \
		cat $(KDIR)/$(IMAGE_PREFIX).dtb.par $(KDIR)/$(KERNEL_IMAGE).par $(KDIR)/$(PROFILE).root.ext4 > $(BIN_DIR)/$(PROFILE)-ext4-firmware.bin ; \
	fi
endef

# FIRMWARE_SIZE(60M)=DTB_PARTITION_SIZE(1M)+KERNEL_PARTITION_SIZE(5M)+SQUASHFS_PARTITION_SIZE(54M)
define Device/Default
	FILESYSTEMS := squashfs
	KERNEL := kernel-bin | gzip | uImage gzip
	DEVICE_DTS :=
	IMAGES :=

	IMAGES = firmware.bin
	IMAGE/firmware.bin = mk_firmware $$(DEVICE_DTS) $$(DTB_PARTITION_SIZE) \
		$$(KERNEL_PARTITION_SIZE) $$(SQUASHFS_PARTITION_SIZE) $$$$(FIRMWARE_SIZE)
endef
DEVICE_VARS += DEVICE_DTS

ifeq ($(SUBTARGET),64b)
define Device/ls1043ardb-64bit
	KERNEL_LOADADDR = 0x80080000
	KERNEL_ENTRY_POINT = 0x80080000
	DEVICE_DTS = freescale/fsl-ls1043a-rdb

	DTB_PARTITION_SIZE := 1024k
	KERNEL_PARTITION_SIZE := 5120k
	SQUASHFS_PARTITION_SIZE := 55296k
	FIRMWARE_SIZE := 61440k
endef

define Device/ls1012ardb-64bit
	KERNEL_LOADADDR = 0x80080000
	KERNEL_ENTRY_POINT = 0x80080000
	DEVICE_DTS = freescale/fsl-ls1012a-rdb

	DTB_PARTITION_SIZE := 1024k
	KERNEL_PARTITION_SIZE := 5120k
	SQUASHFS_PARTITION_SIZE := 50176k
	FIRMWARE_SIZE := 56320k
endef
endif

ifeq ($(SUBTARGET),32b)
define Device/ls1043ardb-32bit
	KERNEL_LOADADDR = 0x80008000
	KERNEL_ENTRY_POINT = 0x80008000
	DEVICE_DTS = ../../../arm64/boot/dts/freescale/fsl-ls1043a-rdb

	DTB_PARTITION_SIZE := 1024k
	KERNEL_PARTITION_SIZE := 5120k
	SQUASHFS_PARTITION_SIZE := 55296k
	FIRMWARE_SIZE := 61440k
endef

define Device/ls1012ardb-32bit
	KERNEL_LOADADDR = 0x80008000
	KERNEL_ENTRY_POINT = 0x80008000
	DEVICE_DTS = ../../../arm64/boot/dts/freescale/fsl-ls1012a-rdb

	DTB_PARTITION_SIZE := 1024k
	KERNEL_PARTITION_SIZE := 5120k
	SQUASHFS_PARTITION_SIZE := 50176k
	FIRMWARE_SIZE := 56320k
endef
endif
TARGET_DEVICES += $(PROFILE)

$(eval $(call BuildImage))
