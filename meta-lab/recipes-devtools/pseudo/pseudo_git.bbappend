# Update pseudo to 1.9.11, which includes fixes for *at() file-descriptor handling.
SRC_URI = "git://git.yoctoproject.org/pseudo;branch=master;protocol=https; \
           file://fallback-passwd \
           file://fallback-group \
           "

SRCREV = "ba8887e5f1e922f866681ec7dec1a00b602a9328"
PV = "1.9.11"

SRC_URI:remove:class-native = "file://older-glibc-symbols.patch"
SRC_URI:remove:class-nativesdk = "file://older-glibc-symbols.patch"