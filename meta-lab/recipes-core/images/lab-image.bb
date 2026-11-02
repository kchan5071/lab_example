SUMMARY = "MicroZed and ZUBoard lab image"
LICENSE = "MIT"
inherit core-image
IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
IMAGE_LINGUAS = " "
do_image_wic[depends] += "lab-bootconf:do_deploy"

IMAGE_FSTYPES += "wic wic.bmap"
WKS_FILE = "lab-sd.wks"
IMAGE_BOOT_FILES = "boot.bin;BOOT.BIN zImage system.dtb extlinux.conf;extlinux/extlinux.conf"