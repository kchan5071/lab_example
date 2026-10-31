FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential chrpath cpio debianutils diffstat file gawk gcc git \
    iputils-ping libacl1 liblz4-tool locales python3 python3-git \
    python3-jinja2 python3-pexpect python3-pip python3-subunit socat \
    texinfo unzip wget xz-utils zstd ca-certificates curl rsync sudo ripgrep \
    bc bison flex libssl-dev libncurses-dev lzop u-boot-tools \
    dosfstools mtools parted device-tree-compiler zip time vim-tiny \
    && locale-gen en_US.UTF-8 && rm -rf /var/lib/apt/lists/*
RUN groupadd -g ${GROUP_ID} builder \
    && useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash builder
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
USER builder
WORKDIR /work