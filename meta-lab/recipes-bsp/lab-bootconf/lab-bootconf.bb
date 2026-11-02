SUMMARY = "MicroZed SD boot configuration"
LICENSE = "CLOSED"

SRC_URI = "file://extlinux.conf"

inherit deploy

do_deploy() {
    install -D -m 0644 ${WORKDIR}/extlinux.conf ${DEPLOYDIR}/extlinux.conf
}

addtask deploy after do_unpack before do_build