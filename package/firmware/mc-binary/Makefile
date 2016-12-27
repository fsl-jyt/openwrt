#
# Copyright (C) 2016 Jiang Yutang <jiangyutang1978@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

PKG_NAME:=mc-binary
PKG_VERSION:=v1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/fsl-jyt/mc-binary.git
PKG_SOURCE_VERSION:=345fc2f9270876b1db1a769c10cdccbe7f0a183c
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=Licenses/README

include $(INCLUDE_DIR)/package.mk

define mc-binary/Default
	TITLE:=
	CONFIG:=
endef

define mc-binary/ls1088ardb
	TITLE:=DPAA2 firmware $(PKG_NAME)-$(PKG_VERSION) for NXP ls1088ardb Dev Board
	CONFIG:=ls1088ardb/ls1088ardb.mc ls1088ardb/ls1088ardb.dpc ls1088ardb/ls1088ardb.dpl
endef

define mc-binary/ls2088ardb
	TITLE:=DPAA2 firmware $(PKG_NAME)-$(PKG_VERSION) for NXP ls2088ardb Dev Board
	CONFIG:=ls2088ardb/ls2088ardb.mc ls2088ardb/ls2088ardb.dpc ls2088ardb/ls2088ardb.dpl
endef

MCBINARYS := \
	ls1088ardb \
	ls2088ardb

define Package/mc-binary/template
define Package/mc-binary-$(1)
	SECTION:=firmware
	CATEGORY:=Firmware
	DEPENDS:=@TARGET_layerscape
	TITLE:=$(2)
	URL:=https://github.com/fsl-jyt/mc-binary.git
	VARIANT:=$(1)
	MAINTAINER:=Jiang Yutang <jiangyutang1978@gmail.com>
endef
endef

define BuildMCBINARYPackage
	$(eval $(mc-binary/Default))
	$(eval $(mc-binary/$(1)))
	$(call Package/mc-binary/template,$(1),$(TITLE))
endef

ifdef BUILD_VARIANT
$(eval $(call mc-binary/$(BUILD_VARIANT)))
MCBINARY_CONFIG:=$(if $(CONFIG),$(CONFIG),$(BUILD_VARIANT))
endif

define Build/Compile
endef

define Package/mc-binary/install/default
	$(foreach i,$(MCBINARY_CONFIG), \
		$(CP) $(PKG_BUILD_DIR)/$(i) $(KDIR)/ ;\
	)
endef

define Package/mc-binary/install/template
define Package/mc-binary-$(1)/install
	$(call Package/mc-binary/install/default,$$(1),$(2))
endef
endef

$(foreach p,$(MCBINARYS), \
	$(eval $(call Package/mc-binary/install/template,$(p),$(p))) \
)

$(foreach p,$(MCBINARYS), \
	$(eval $(call BuildMCBINARYPackage,$(p))) \
	$(eval $(call BuildPackage,mc-binary-$(p))) \
)
