#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=thin-provisioning-tools
PKG_VERSION:=0.7.6
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/jthornber/thin-provisioning-tools.git
PKG_SOURCE_DATE:=2018-05-22
PKG_SOURCE_VERSION:=6a7351da0d3d1348a13752627d1f820acf34c42f
PKG_MIRROR_HASH:=1bc3c9e3e38f1f56d05a05b3dd8b412310ee6e118078da3d606cf389cbb94c0c

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:jthornber:thin-provisioning-tools

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/thin-provisioning-tools
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Filesystem
	TITLE:=Tools for metadata manipulation for dm targets
	URL:=https://github.com/jthornber/thin-provisioning-tools
	DEPENDS:=+boost +libexpat +libaio
endef

define Package/thin-provisioning-tools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/pdata_tools $(1)/usr/bin
	$(STRIP) $(1)/usr/bin/pdata_tools
	ln -s -f pdata_tools $(1)/usr/bin/cache_check
	ln -s -f pdata_tools $(1)/usr/bin/cache_dump
	ln -s -f pdata_tools $(1)/usr/bin/cache_metadata_size
	ln -s -f pdata_tools $(1)/usr/bin/cache_repair
	ln -s -f pdata_tools $(1)/usr/bin/cache_restore
	ln -s -f pdata_tools $(1)/usr/bin/cache_writeback
	ln -s -f pdata_tools $(1)/usr/bin/thin_check
	ln -s -f pdata_tools $(1)/usr/bin/thin_delta
	ln -s -f pdata_tools $(1)/usr/bin/thin_dump
	ln -s -f pdata_tools $(1)/usr/bin/thin_ls
	ln -s -f pdata_tools $(1)/usr/bin/thin_repair
	ln -s -f pdata_tools $(1)/usr/bin/thin_restore
	ln -s -f pdata_tools $(1)/usr/bin/thin_rmap
	ln -s -f pdata_tools $(1)/usr/bin/thin_metadata_size
	ln -s -f pdata_tools $(1)/usr/bin/thin_trim
	ln -s -f pdata_tools $(1)/usr/bin/era_check
	ln -s -f pdata_tools $(1)/usr/bin/era_dump
	ln -s -f pdata_tools $(1)/usr/bin/era_invalidate
	ln -s -f pdata_tools $(1)/usr/bin/era_restore
endef

$(eval $(call BuildPackage,thin-provisioning-tools))
