#
# Copyright (C) 2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=aarch64
BOARD:=layerscape-64b
BOARDNAME:=layerscape 64b
CFLAGS:=-Os -pipe -fno-caller-saves
DEVICE_TYPE:=developerboard
KERNEL_PATCHVER:=4.1
KERNELNAME:=Image dtbs
FEATURES:=squashfs
SUBTARGETS:=ls1043ardb
MAINTAINER:=Jiang Yutang <yutang.jiang@nxp.com>

include $(INCLUDE_DIR)/target.mk

define Target/Description
	Build firmware images for $(BOARDNAME) SoC devices.
endef

$(eval $(call BuildTarget))
