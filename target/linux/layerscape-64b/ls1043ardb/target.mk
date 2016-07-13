#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
BOARDNAME += $(SUBTARGET)

# subtarget macros
# PARTITION_SIZE unit: (M)
define Subtarget/Default
	DEVICE_DTS = freescale/fsl-ls1043a-rdb
	DTB_PARTITION_SIZE = 1
	KERNEL_PARTITION_SIZE = 5
	SQUASHFS_PARTITION_SIZE = 54
endef
