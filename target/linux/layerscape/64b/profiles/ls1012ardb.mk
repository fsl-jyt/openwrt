#
# Copyright (C) 2016 Jiang Yutang <jiangyutang1978@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/ls1012ardb
	NAME:=ls1012ardb Profile
endef

define Profile/ls1012ardb/Description
	ls1012ardb Description
endef

$(eval $(call Profile,ls1012ardb))
