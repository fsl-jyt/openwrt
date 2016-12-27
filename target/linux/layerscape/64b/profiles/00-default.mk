define Profile/Default
	NAME:=Default Profile
	PRIORITY:=1
endef

define Profile/Default/Description
	Default package set compatible with most boards.
endef

DEFAULT_PACKAGES+= \
	rcw-layerscape-ls1043ardb uboot-layerscape-$(SUBTARGET)-ls1043ardb \
	fman-layerscape-ls1043ardb \
	rcw-layerscape-ls1046ardb uboot-layerscape-$(SUBTARGET)-ls1046ardb \
	fman-layerscape-ls1046ardb \
	rcw-layerscape-ls1012ardb uboot-layerscape-$(SUBTARGET)-ls1012ardb \
	kmod-ppfe ppfe-ls1012ardb \
	rcw-layerscape-ls1088ardb uboot-layerscape-$(SUBTARGET)-ls1088ardb \
	mc-binary-ls1088ardb \
	rcw-layerscape-ls2088ardb uboot-layerscape-$(SUBTARGET)-ls2088ardb \
	mc-binary-ls2088ardb

$(eval $(call Profile,Default))
