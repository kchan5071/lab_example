#!/usr/bin/env bash
set -euo pipefail

BOOTGEN_COMMIT="6f448fece5d999985128fd454ae047e065a5e45d"
BOOTGEN_REPO="https://github.com/Xilinx/bootgen.git"
INSTALL_DIR="${BOOTGEN_INSTALL_DIR:-$HOME/.local/bin}"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

missing_dependencies=()
for command_name in git make g++; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        missing_dependencies+=("$command_name")
    fi
done
if [[ ! -f /usr/include/openssl/ssl.h ]]; then
    missing_dependencies+=("libssl-dev")
fi

if ((${#missing_dependencies[@]} > 0)); then
    if ! command -v apt-get >/dev/null 2>&1; then
        echo "Missing dependencies: ${missing_dependencies[*]}. Install them with your distribution's package manager." >&2
        exit 1
    fi

    if [[ "${EUID}" -eq 0 ]]; then
        apt-get update
        apt-get install -y ca-certificates build-essential git libssl-dev
    elif command -v sudo >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y ca-certificates build-essential git libssl-dev
    else
        echo "Missing dependencies: ${missing_dependencies[*]}. Run as root or install them with sudo apt-get." >&2
        exit 1
    fi
fi

git init "$WORK_DIR/bootgen"
git -C "$WORK_DIR/bootgen" remote add origin "$BOOTGEN_REPO"
git -C "$WORK_DIR/bootgen" fetch --depth 1 origin "$BOOTGEN_COMMIT"
git -C "$WORK_DIR/bootgen" checkout --detach FETCH_HEAD

make -C "$WORK_DIR/bootgen" -j"$(nproc)"
install -D -m 0755 "$WORK_DIR/bootgen/bootgen" "$INSTALL_DIR/bootgen"

echo "Installed Bootgen to $INSTALL_DIR/bootgen"
"$INSTALL_DIR/bootgen" -help
