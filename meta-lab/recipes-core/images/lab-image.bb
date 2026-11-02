SUMMARY = "MicroZed and ZUBoard lab image"
LICENSE = "MIT"
inherit core-image
IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"
IMAGE_LINGUAS = " "
do_image_wic[depends] += "lab-bootconf:do_deploy"

IMAGE_FSTYPES += "wic wic.bmap"
WKS_FILE = "lab-sd.wks"
WKS_FILES = "lab-sd.wks"
IMAGE_BOOT_FILES = "boot.bin;BOOT.BIN zImage system.dtb extlinux.conf;extlinux/extlinux.conf"

inherit extrausers

IMAGE_INSTALL:append = " \
    python3-core python3-modules \
    bash coreutils findutils grep sed gawk \
    iproute2 iputils ethtool procps util-linux \
    less nano strace os-release\
"

IMAGE_FEATURES:append = " ssh-server-dropbear"


EXTRA_USERS_PARAMS:append = " useradd -m -s /bin/sh developer; usermod -p '\$6\$vegFGyRPSyd1ze1E\$VdTg3dyXNl0hSeNiynbRH5UfoeWvdHu3nMUg4rbRl4UM2Z03zZtycY7WIxnUH16r8bGf9RZqyzHqhdl.ogPb0/' developer;"