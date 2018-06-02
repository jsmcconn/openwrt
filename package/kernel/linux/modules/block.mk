#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

BLOCK_MENU:=Block Devices

define KernelPackage/aoe
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=ATA over Ethernet support
  KCONFIG:=CONFIG_ATA_OVER_ETH
  FILES:=$(LINUX_DIR)/drivers/block/aoe/aoe.ko
  AUTOLOAD:=$(call AutoLoad,30,aoe)
endef

define KernelPackage/aoe/description
 Kernel support for ATA over Ethernet
endef

$(eval $(call KernelPackage,aoe))


define KernelPackage/ata-core
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Serial and Parallel ATA support
  DEPENDS:=@PCI_SUPPORT||TARGET_sunxi +kmod-scsi-core
  KCONFIG:=CONFIG_ATA
  FILES:=$(LINUX_DIR)/drivers/ata/libata.ko
ifneq ($(wildcard $(LINUX_DIR)/drivers/ata/libahci.ko),)
  FILES+=$(LINUX_DIR)/drivers/ata/libahci.ko
endif
endef

$(eval $(call KernelPackage,ata-core))


define AddDepends/ata
  SUBMENU:=$(BLOCK_MENU)
  DEPENDS+=kmod-ata-core $(1)
endef


define KernelPackage/ata-ahci
  TITLE:=AHCI Serial ATA support
  KCONFIG:=CONFIG_SATA_AHCI
  FILES:= \
    $(LINUX_DIR)/drivers/ata/ahci.ko
  AUTOLOAD:=$(call AutoLoad,41,libahci ahci,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-ahci/description
 Support for AHCI Serial ATA controllers
endef

$(eval $(call KernelPackage,ata-ahci))


define KernelPackage/ata-ahci-platform
  TITLE:=AHCI Serial ATA Platform support
  KCONFIG:=CONFIG_SATA_AHCI_PLATFORM
  FILES:= \
    $(LINUX_DIR)/drivers/ata/ahci_platform.ko \
    $(LINUX_DIR)/drivers/ata/libahci_platform.ko
  AUTOLOAD:=$(call AutoLoad,40,libahci libahci_platform ahci_platform,1)
  $(call AddDepends/ata,@TARGET_ipq806x||TARGET_sunxi)
endef

define KernelPackage/ata-ahci-platform/description
 Platform support for AHCI Serial ATA controllers
endef

$(eval $(call KernelPackage,ata-ahci-platform))


define KernelPackage/ata-artop
  TITLE:=ARTOP 6210/6260 PATA support
  KCONFIG:=CONFIG_PATA_ARTOP
  FILES:=$(LINUX_DIR)/drivers/ata/pata_artop.ko
  AUTOLOAD:=$(call AutoLoad,41,pata_artop,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-artop/description
 PATA support for ARTOP 6210/6260 host controllers
endef

$(eval $(call KernelPackage,ata-artop))


define KernelPackage/ata-marvell-sata
  TITLE:=Marvell Serial ATA support
  KCONFIG:=CONFIG_SATA_MV
  FILES:=$(LINUX_DIR)/drivers/ata/sata_mv.ko
  AUTOLOAD:=$(call AutoLoad,41,sata_mv,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-marvell-sata/description
 SATA support for marvell chipsets
endef

$(eval $(call KernelPackage,ata-marvell-sata))


define KernelPackage/ata-nvidia-sata
  TITLE:=Nvidia Serial ATA support
  KCONFIG:=CONFIG_SATA_NV
  FILES:=$(LINUX_DIR)/drivers/ata/sata_nv.ko
  AUTOLOAD:=$(call AutoLoad,41,sata_nv,1)
  $(call AddDepends/ata)
endef

$(eval $(call KernelPackage,ata-nvidia-sata))


define KernelPackage/ata-pdc202xx-old
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Older Promise PATA controller support
  DEPENDS:=kmod-ata-core
  KCONFIG:= \
       CONFIG_ATA_SFF=y \
       CONFIG_PATA_PDC_OLD
  FILES:=$(LINUX_DIR)/drivers/ata/pata_pdc202xx_old.ko
  AUTOLOAD:=$(call AutoLoad,41,pata_pdc202xx_old,1)
endef

define KernelPackage/ata-pdc202xx-old/description
 This option enables support for the Promise 20246, 20262, 20263,
 20265 and 20267 adapters
endef

$(eval $(call KernelPackage,ata-pdc202xx-old))


define KernelPackage/ata-piix
  TITLE:=Intel PIIX PATA/SATA support
  KCONFIG:=CONFIG_ATA_PIIX
  FILES:=$(LINUX_DIR)/drivers/ata/ata_piix.ko
  AUTOLOAD:=$(call AutoLoad,41,ata_piix,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-piix/description
 SATA support for Intel ICH5/6/7/8 series host controllers and
 PATA support for Intel ESB/ICH/PIIX3/PIIX4 series host controllers
endef

$(eval $(call KernelPackage,ata-piix))


define KernelPackage/ata-sil
  TITLE:=Silicon Image SATA support
  KCONFIG:=CONFIG_SATA_SIL
  FILES:=$(LINUX_DIR)/drivers/ata/sata_sil.ko
  AUTOLOAD:=$(call AutoLoad,41,sata_sil,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-sil/description
 Support for Silicon Image Serial ATA controllers
endef

$(eval $(call KernelPackage,ata-sil))


define KernelPackage/ata-sil24
  TITLE:=Silicon Image 3124/3132 SATA support
  KCONFIG:=CONFIG_SATA_SIL24
  FILES:=$(LINUX_DIR)/drivers/ata/sata_sil24.ko
  AUTOLOAD:=$(call AutoLoad,41,sata_sil24,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-sil24/description
 Support for Silicon Image 3124/3132 Serial ATA controllers
endef

$(eval $(call KernelPackage,ata-sil24))


define KernelPackage/ata-via-sata
  TITLE:=VIA SATA support
  KCONFIG:=CONFIG_SATA_VIA
  FILES:=$(LINUX_DIR)/drivers/ata/sata_via.ko
  AUTOLOAD:=$(call AutoLoad,41,sata_via,1)
  $(call AddDepends/ata)
endef

define KernelPackage/ata-via-sata/description
 This option enables support for VIA Serial ATA
endef

$(eval $(call KernelPackage,ata-via-sata))


define KernelPackage/block2mtd
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Block device MTD emulation
  KCONFIG:=CONFIG_MTD_BLOCK2MTD
  FILES:=$(LINUX_DIR)/drivers/mtd/devices/block2mtd.ko
endef

$(eval $(call KernelPackage,block2mtd))


define KernelPackage/dax
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=DAX: direct access to differentiated memory
  DEPENDS:=@!(LINUX_3_18||LINUX_4_1||LINUX_4_4)
  KCONFIG:=CONFIG_DAX
  FILES:=$(LINUX_DIR)/drivers/dax/dax.ko
endef

$(eval $(call KernelPackage,dax))


define KernelPackage/bcache
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Kernel Bcache Support
  KCONFIG:= \
  CONFIG_MD=y \
  CONFIG_BLK_DEV_MD=n \
  CONFIG_BCACHE \
  CONFIG_BCACHE_DEBUG=n \
  CONFIG_BCACHE_CLOSURES_DEBUG=n
  FILES:=$(LINUX_DIR)/drivers/md/bcache/bcache.ko
  AUTOLOAD:=$(call AutoLoad,30,bcache)
endef

define KernelPackage/bcache/description
 Kernel block layer cache support (bcache.ko)
endef

$(eval $(call KernelPackage,bcache))


define KernelPackage/dm
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Device Mapper (LVM2)
  DEPENDS:=+LINUX_4_14:kmod-dax
  # In order to handle the build select chain most modules are built here then
  # packaged separately.
  KCONFIG:= \
  CONFIG_MD=y \
  CONFIG_BLK_DEV_MD=n \
	CONFIG_BLK_DEV_DM \
	CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=n \
	CONFIG_DM_PERSISTENT_DATA \
	CONFIG_DM_SNAPSHOT \
	CONFIG_DM_THIN_PROVISIONING \
	CONFIG_DM_CACHE \
	CONFIG_DM_CACHE_SMQ \
	CONFIG_DM_ERA \
	CONFIG_DM_MIRROR \
	CONFIG_DM_ZERO
  FILES:=$(LINUX_DIR)/drivers/md/dm-mod.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-mod)
endef

define KernelPackage/dm/description
 Device-mapper low level volume manager (LVM2)
endef

$(eval $(call KernelPackage,dm))


define KernelPackage/md-dm/Depends
  SUBMENU:=$(BLOCK_MENU)
  DEPENDS:=kmod-dm $(1)
endef


define KernelPackage/dm-bufio
$(call KernelPackage/md-dm/Depends,)
  TITLE:=DM Bufferd I/O Support
  KCONFIG:=CONFIG_DM_BUFIO
  FILES:=$(LINUX_DIR)/drivers/md/dm-bufio.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-bufio)
endef

define KernelPackage/dm-bufio/description
 LVM2 buffered io support (dm-bufio.ko)
endef

$(eval $(call KernelPackage,dm-bufio))


define KernelPackage/dm-bio-prison
$(call KernelPackage/md-dm/Depends,)
  TITLE:=DM BIO Locking Support
  KCONFIG:=CONFIG_DM_BIO_PRISON
  FILES:=$(LINUX_DIR)/drivers/md/dm-bio-prison.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-bio-prison)
endef

define KernelPackage/dm-bio-prison/description
 LVM2 BIO locking schemes support (dm-bio-prison.ko)
endef

$(eval $(call KernelPackage,dm-bio-prison))


define KernelPackage/dm-persistent-data
$(call KernelPackage/md-dm/Depends,+kmod-lib-crc32c +kmod-dm-bufio)
  TITLE:=DM Persistent Data Support
  KCONFIG:=CONFIG_DM_PERSISTENT_DATA
  FILES:= $(LINUX_DIR)/drivers/md/persistent-data/dm-persistent-data.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-persistent-data)
endef

define KernelPackage/dm-persistent-data/description
 LVM2 immutable data structure support library (dm-persistent-data.ko)
endef

$(eval $(call KernelPackage,dm-persistent-data))


define KernelPackage/dm-crypt
$(call KernelPackage/md-dm/Depends,+kmod-crypto-manager)
  TITLE:=DM Crypt Target
  KCONFIG:= CONFIG_DM_CRYPT
  FILES:= $(LINUX_DIR)/drivers/md/dm-crypt.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-crypt)
endef

define KernelPackage/dm-crypt/description
 LVM2 encrypted target driver (dm-crypt.ko)
endef

$(eval $(call KernelPackage,dm-crypt))


define KernelPackage/dm-snapshot
$(call KernelPackage/md-dm/Depends,+kmod-dm-bufio)
  TITLE:=DM Writable Snapshot
  KCONFIG:=CONFIG_DM_SNAPSHOT
  FILES:=$(LINUX_DIR)/drivers/md/dm-snapshot.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-snapshot)
endef

define KernelPackage/dm-snapshot/description
 LVM2 writable snapshot driver (dm-snapshot.ko)
endef

$(eval $(call KernelPackage,dm-snapshot))


define KernelPackage/dm-thin-pool
$(call KernelPackage/md-dm/Depends,+kmod-dm-persistent-data +kmod-dm-bio-prison)
  TITLE:=DM Thin Provisioning
  KCONFIG:=CONFIG_DM_THIN_PROVISIONING
  FILES:=$(LINUX_DIR)/drivers/md/dm-thin-pool.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-thin-pool)
endef

define KernelPackage/dm-thin-pool/description
 LVM2 thin provisioning and shared data snapshots (dm-thin-pool.ko)
endef

$(eval $(call KernelPackage,dm-thin-pool))


define KernelPackage/dm-cache
$(call KernelPackage/md-dm/Depends,+kmod-dm-persistent-data +kmod-dm-bio-prison)
  TITLE:=DM Cache Target (experimental)
  KCONFIG:= \
  CONFIG_DM_CACHE \
  CONFIG_DM_CACHE_SMQ
  FILES:= \
  $(LINUX_DIR)/drivers/md/dm-cache.ko \
  $(LINUX_DIR)/drivers/md/dm-cache-smq.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-cache dm-cache-smq)
endef

define KernelPackage/dm-cache/description
 LVM2 block device caching modules (dm-cache.ko dm-cache-smq.ko)
endef

$(eval $(call KernelPackage,dm-cache))


define KernelPackage/dm-era
$(call KernelPackage/md-dm/Depends,+kmod-dm-persistent-data +kmod-dm-bio-prison)
  TITLE:=DM Era Target (experimental)
  KCONFIG:=CONFIG_DM_ERA
  FILES:=$(LINUX_DIR)/drivers/md/dm-era.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-era)
endef

define KernelPackage/dm-era/description
 LVM2 block device write tracking (dm-era.ko)
endef

$(eval $(call KernelPackage,dm-era))


define KernelPackage/dm-mirror
$(call KernelPackage/md-dm/Depends,)
  TITLE:=DM Mirror Target
  KCONFIG:=CONFIG_DM_MIRROR
  FILES:= \
  $(LINUX_DIR)/drivers/md/dm-mirror.ko \
  $(LINUX_DIR)/drivers/md/dm-log.ko \
  $(LINUX_DIR)/drivers/md/dm-region-hash.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-mirror dm-log dm-region-hash)
endef

define KernelPackage/dm-mirror/description
 LVM2 mirror target driver modules (dm-mirror.ko dm-log.ko dm-region-hash.ko)
endef

$(eval $(call KernelPackage,dm-mirror))


define KernelPackage/dm-raid
$(call KernelPackage/md-dm/Depends,+kmod-md-mod +kmod-md-raid0 +kmod-md-raid1 \
  +kmod-md-raid10 +kmod-md-raid456)
  TITLE:=DM RAID Target
  KCONFIG:=CONFIG_DM_RAID
  FILES:=$(LINUX_DIR)/drivers/md/dm-raid.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-raid)
endef

define KernelPackage/dm-raid/description
 LVM2 raid target support (dm-raid.ko)
endef

$(eval $(call KernelPackage,dm-raid))


define KernelPackage/dm-zero
$(call KernelPackage/md-dm/Depends,)
  TITLE:=DM Zero Target
  KCONFIG:=CONFIG_DM_ZERO
  FILES:=$(LINUX_DIR)/drivers/md/dm-zero.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-zero)
endef

define KernelPackage/dm-zero/description
 LVM2 zero target for recovery support (dm-zero.ko)
endef

$(eval $(call KernelPackage,dm-zero))


define KernelPackage/dm-multipath
$(call KernelPackage/md-dm/Depends,+kmod-scsi-core)
  TITLE:=DM Multipath Hardware Support
  KCONFIG:= \
  CONFIG_DM_MULTIPATH \
  CONFIG_DM_MULTIPATH_QL \
  CONFIG_DM_MULTIPATH_ST
  FILES:= \
  $(LINUX_DIR)/drivers/md/dm-multipath.ko \
  $(LINUX_DIR)/drivers/md/dm-round-robin.ko \
  $(LINUX_DIR)/drivers/md/dm-queue-length.ko \
  $(LINUX_DIR)/drivers/md/dm-service-time.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-multipath dm-round-robin dm-queue-length \
    dm-service-time)
endef

define KernelPackage/dm-multipath/description
 LVM2 multipath hardware support (dm-multipath.ko dm-round-robin.ko
 dm-queue-length.ko dm-service-time.ko)
endef

$(eval $(call KernelPackage,dm-multipath))


define KernelPackage/dm-integrity
$(call KernelPackage/md-dm/Depends,+kmod-dm-bufio +kmod-crypto-manager \
  +kmod-md-raid456)
  TITLE:=DM Integrity Target
  KCONFIG:=CONFIG_DM_INTEGRITY
  FILES:=$(LINUX_DIR)/drivers/md/dm-integrity.ko
  AUTOLOAD:=$(call AutoLoad,30,dm-integrity)
endef

define KernelPackage/dm-integrity/description
 LVM2 integrity target for dm-crypt support (dm-integrity.ko)
endef

$(eval $(call KernelPackage,dm-integrity))


define KernelPackage/md-mod
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=MD RAID
  KCONFIG:= \
       CONFIG_MD=y \
       CONFIG_BLK_DEV_MD=m \
       CONFIG_MD_AUTODETECT=y \
       CONFIG_MD_FAULTY=n
  FILES:=$(LINUX_DIR)/drivers/md/md-mod.ko
  AUTOLOAD:=$(call AutoLoad,27,md-mod)
endef

define KernelPackage/md-mod/description
 Kernel RAID md module (md-mod.ko).
 You will need to select at least one RAID level module below.
endef

$(eval $(call KernelPackage,md-mod))


define KernelPackage/md/Depends
  SUBMENU:=$(BLOCK_MENU)
  DEPENDS:=kmod-md-mod $(1)
endef


define KernelPackage/md-linear
$(call KernelPackage/md/Depends,)
  TITLE:=RAID Linear Module
  KCONFIG:=CONFIG_MD_LINEAR
  FILES:=$(LINUX_DIR)/drivers/md/linear.ko
  AUTOLOAD:=$(call AutoLoad,28,linear)
endef

define KernelPackage/md-linear/description
 RAID "Linear" or "Append" driver module (linear.ko)
endef

$(eval $(call KernelPackage,md-linear))


define KernelPackage/md-raid0
$(call KernelPackage/md/Depends,)
  TITLE:=RAID0 Module
  KCONFIG:=CONFIG_MD_RAID0
  FILES:=$(LINUX_DIR)/drivers/md/raid0.ko
  AUTOLOAD:=$(call AutoLoad,28,raid0)
endef

define KernelPackage/md-raid0/description
 RAID Level 0 (Striping) driver module (raid0.ko)
endef

$(eval $(call KernelPackage,md-raid0))


define KernelPackage/md-raid1
$(call KernelPackage/md/Depends,)
  TITLE:=RAID1 Module
  KCONFIG:=CONFIG_MD_RAID1
  FILES:=$(LINUX_DIR)/drivers/md/raid1.ko
  AUTOLOAD:=$(call AutoLoad,28,raid1)
endef

define KernelPackage/md-raid1/description
 RAID Level 1 (Mirroring) driver (raid1.ko)
endef

$(eval $(call KernelPackage,md-raid1))


define KernelPackage/md-raid10
$(call KernelPackage/md/Depends,)
  TITLE:=RAID10 Module
  KCONFIG:=CONFIG_MD_RAID10
  FILES:=$(LINUX_DIR)/drivers/md/raid10.ko
  AUTOLOAD:=$(call AutoLoad,28,raid10)
endef

define KernelPackage/md-raid10/description
 RAID Level 10 (Mirroring+Striping) driver module (raid10.ko)
endef

$(eval $(call KernelPackage,md-raid10))


define KernelPackage/md-raid456
$(call KernelPackage/md/Depends,+kmod-lib-raid6 +kmod-lib-xor +!LINUX_3_18:kmod-lib-crc32c)
  TITLE:=RAID Level 456 Driver
  KCONFIG:= \
       CONFIG_ASYNC_CORE \
       CONFIG_ASYNC_MEMCPY \
       CONFIG_ASYNC_XOR \
       CONFIG_ASYNC_PQ \
       CONFIG_ASYNC_RAID6_RECOV \
       CONFIG_ASYNC_RAID6_TEST=n \
       CONFIG_MD_RAID456 \
       CONFIG_MULTICORE_RAID456=n
  FILES:= \
	$(LINUX_DIR)/crypto/async_tx/async_tx.ko \
	$(LINUX_DIR)/crypto/async_tx/async_memcpy.ko \
	$(LINUX_DIR)/crypto/async_tx/async_xor.ko \
	$(LINUX_DIR)/crypto/async_tx/async_pq.ko \
	$(LINUX_DIR)/crypto/async_tx/async_raid6_recov.ko \
	$(LINUX_DIR)/drivers/md/raid456.ko
  AUTOLOAD:=$(call AutoLoad,28, async_tx async_memcpy async_xor async_pq async_raid6_recov raid456)
endef

define KernelPackage/md-raid456/description
 RAID Level 4,5,6 kernel module (raid456.ko)

 Includes the following modules required by
 raid456.ko:
    xor.ko
    async_tx.ko
    async_xor.ko
    async_memcpy.ko
    async_pq.ko
    async_raid5_recov.ko
    raid6_pq.ko
endef

$(eval $(call KernelPackage,md-raid456))


define KernelPackage/md-multipath
$(call KernelPackage/md/Depends,)
  TITLE:=MD Multipath Module
  KCONFIG:=CONFIG_MD_MULTIPATH
  FILES:=$(LINUX_DIR)/drivers/md/multipath.ko
  AUTOLOAD:=$(call AutoLoad,29,multipath)
endef

define KernelPackage/md-multipath/description
 Multipath driver module (multipath.ko)
endef

$(eval $(call KernelPackage,md-multipath))


define KernelPackage/libsas
  SUBMENU:=$(BLOCK_MENU)
  DEPENDS:=@TARGET_x86
  TITLE:=SAS Domain Transport Attributes
  KCONFIG:=CONFIG_SCSI_SAS_LIBSAS \
	CONFIG_SCSI_SAS_ATTRS \
	CONFIG_SCSI_SAS_ATA=y \
	CONFIG_SCSI_SAS_HOST_SMP=y \
	CONFIG_SCSI_SAS_LIBSAS_DEBUG=y
  FILES:= \
	$(LINUX_DIR)/drivers/scsi/scsi_transport_sas.ko \
	$(LINUX_DIR)/drivers/scsi/libsas/libsas.ko
  AUTOLOAD:=$(call AutoLoad,29,scsi_transport_sas libsas,1)
endef

define KernelPackage/libsas/description
 SAS Domain Transport Attributes support
endef

$(eval $(call KernelPackage,libsas,1))


define KernelPackage/loop
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Loopback device support
  KCONFIG:= \
	CONFIG_BLK_DEV_LOOP \
	CONFIG_BLK_DEV_CRYPTOLOOP=n
  FILES:=$(LINUX_DIR)/drivers/block/loop.ko
  AUTOLOAD:=$(call AutoLoad,30,loop)
endef

define KernelPackage/loop/description
 Kernel module for loopback device support
endef

$(eval $(call KernelPackage,loop))


define KernelPackage/mvsas
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Marvell 88SE6440 SAS/SATA driver
  DEPENDS:=@TARGET_x86 +kmod-libsas
  KCONFIG:= \
	CONFIG_SCSI_MVSAS \
	CONFIG_SCSI_MVSAS_TASKLET=n
  FILES:=$(LINUX_DIR)/drivers/scsi/mvsas/mvsas.ko
  AUTOLOAD:=$(call AutoLoad,40,mvsas,1)
endef

define KernelPackage/mvsas/description
 Kernel support for the Marvell SAS SCSI adapters
endef

$(eval $(call KernelPackage,mvsas))


define KernelPackage/nbd
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Network block device support
  KCONFIG:=CONFIG_BLK_DEV_NBD
  FILES:=$(LINUX_DIR)/drivers/block/nbd.ko
  AUTOLOAD:=$(call AutoLoad,30,nbd)
endef

define KernelPackage/nbd/description
 Kernel module for network block device support
endef

$(eval $(call KernelPackage,nbd))


define KernelPackage/scsi-core
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=SCSI device support
  KCONFIG:= \
	CONFIG_SCSI \
	CONFIG_BLK_DEV_SD
  FILES:= \
	$(LINUX_DIR)/drivers/scsi/scsi_mod.ko \
	$(LINUX_DIR)/drivers/scsi/sd_mod.ko
  AUTOLOAD:=$(call AutoLoad,40,scsi_mod sd_mod,1)
endef

$(eval $(call KernelPackage,scsi-core))


define KernelPackage/scsi-generic
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Kernel support for SCSI generic
  DEPENDS:=+kmod-scsi-core
  KCONFIG:= \
	CONFIG_CHR_DEV_SG
  FILES:= \
	$(LINUX_DIR)/drivers/scsi/sg.ko
  AUTOLOAD:=$(call AutoLoad,65,sg)
endef

$(eval $(call KernelPackage,scsi-generic))


define KernelPackage/scsi-cdrom
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Kernel support for CD / DVD drives
  DEPENDS:=+kmod-scsi-core
  KCONFIG:= \
    CONFIG_BLK_DEV_SR \
    CONFIG_BLK_DEV_SR_VENDOR=n
  FILES:= \
    $(LINUX_DIR)/drivers/cdrom/cdrom.ko \
    $(LINUX_DIR)/drivers/scsi/sr_mod.ko
  AUTOLOAD:=$(call AutoLoad,45,sr_mod)
endef

$(eval $(call KernelPackage,scsi-cdrom))


define KernelPackage/scsi-tape
  SUBMENU:=$(BLOCK_MENU)
  TITLE:=Kernel support for scsi tape drives
  DEPENDS:=+kmod-scsi-core
  KCONFIG:= \
    CONFIG_CHR_DEV_ST
  FILES:= \
    $(LINUX_DIR)/drivers/scsi/st.ko
  AUTOLOAD:=$(call AutoLoad,45,st)
endef

$(eval $(call KernelPackage,scsi-tape))
