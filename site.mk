DEFAULT_GLUON_RELEASE := 2017.11.1~$(shell date '+%Y%m%d')
DEFAULT_GLUON_PRIORITY := 0

# languages to include in images
GLUON_LANGS ?= en de

# region information for regulatory compliance
GLUON_REGION ?= eu

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= ${DEFAULT_GLUON_PRIORITY}

# Prefer ath10k firmware with 802.11s support
GLUON_ATH10K_MESH ?= 11s

# Featureset, these are either virtual or packages prefixed with "gluon-"
GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-segment-mld \
	ebtables-source-filter \
	mesh-batman-adv-15 \
	mesh-vpn-tunneldigger \
	radvd \
	respondd \
	status-page \
	web-advanced \
	web-logging \
	web-private-wifi \
	web-wizard
# TODO: ssid-changer
# TODO: tunneldigger-watchdog

# Additional packages to install on every image
GLUON_SITE_PACKAGES := \
	iwinfo \
	haveged

############################
# Additional package sets
#############################

# USB Human Interface
USB_PKGS_HID := \
	kmod-usb-hid \
	kmod-hid-generic

# USB Serial
USB_PKGS_SERIAL := \
	kmod-usb-serial \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-pl2303

# USB Storage
USB_PKGS_STORAGE := \
	block-mount \
	blkid \
	kmod-fs-exfat \
	kmod-fs-ext4 \
	kmod-fs-ntfs \
	kmod-fs-vfat \
	kmod-usb-storage \
	kmod-usb-storage-extras \
	kmod-nls-base \
	kmod-nls-cp1250 \
	kmod-nls-cp1251 \
	kmod-nls-cp437 \
	kmod-nls-cp850 \
	kmod-nls-cp852 \
	kmod-nls-iso8859-1 \
	kmod-nls-iso8859-13 \
	kmod-nls-iso8859-15 \
	kmod-nls-iso8859-2 \
	kmod-nls-utf8 \
	swap-utils

# USB Wired Ethernet Network
USB_PKGS_NET := \
	kmod-mii \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-asix-ax88179 \
	kmod-usb-net-cdc-eem \
	kmod-usb-net-cdc-ether \
	kmod-usb-net-cdc-subset \
	kmod-usb-net-dm9601-ether \
	kmod-usb-net-hso \
	kmod-usb-net-mcs7830 \
	kmod-usb-net-pegasus \
	kmod-usb-net-rtl8152 \
	kmod-usb-net-smsc95xx

# PCI-Express Network
PCIE_PACKAGES_NET := \
	kmod-bnx2


# Group previous package sets
USB_PKGS_WITHOUT_HID := \
	usbutils \
	$(USB_PKGS_SERIAL) \
	$(USB_PKGS_STORAGE) \
	$(USB_PKGS_NET)

USB_PKGS := \
	$(USB_PKGS_HID) \
	$(USB_PKGS_WITHOUT_HID)

PCIE_PKGS := \
	pciutils \
	$(PCIE_PACKAGES_NET)


##################################
# Assign package sets to targets
##################################

# Embedded Routers
ifeq ($(GLUON_TARGET),ar71xx-generic)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ar71xx-nand)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ipq806x)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7620)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7621)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

ifeq ($(GLUON_TARGET),ramips-mt7628)
GLUON_SITE_PACKAGES += $(USB_PKGS_WITHOUT_HID)
endif

# x86 Generic Purpose Hardware
ifeq ($(GLUON_TARGET),x86-generic)
GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

# PCEngines ALIX Boards
ifeq ($(GLUON_TARGET),x86-geode)
GLUON_SITE_PACKAGES += $(USB_PKGS) $(PCIE_PKGS)
endif

#  Raspberry Pi A/B/B+
ifeq ($(GLUON_TARGET),brcm2708-bcm2708)
GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Raspberry Pi 2
ifeq ($(GLUON_TARGET),brcm2708-bcm2709)
GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Raspberry Pi 3
ifeq ($(GLUON_TARGET),brcm2708-bcm2710)
GLUON_SITE_PACKAGES += $(USB_PKGS)
endif

# Banana Pi/Pro, Lamobo R1
ifeq ($(GLUON_TARGET),sunxi)
GLUON_SITE_PACKAGES += $(USB_PKGS)
endif
