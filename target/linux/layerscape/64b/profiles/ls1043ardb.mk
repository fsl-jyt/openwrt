#
# Copyright (C) 2016 Jiang Yutang <jiangyutang1978@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/ls1043ardb
	NAME:=ls1043ardb Profile
endef

define Profile/ls1043ardb/Description
	ls1043ardb Description
endef

$(eval $(call Profile,ls1043ardb))
