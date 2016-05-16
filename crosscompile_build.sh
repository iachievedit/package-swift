#!/bin/bash
#
# Cross Compile Script
# https://swift-arm.slack.com/files/kawa/F17GA65L4/cross-compiling.txt
#

# target
TARGET="linux-armv6"

while getopts ":t:" opt; do
  case $opt in
    t) TARGET="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

WORKSPACE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INSTALL_DIR=${WORKSPACE}/install
SYSROOT=${WORKSPACE}/crosscompile_support/sysroot
TOOLCHAIN=${WORKSPACE}/crosscompile_support/toolchain/bin
./swift/utils/build-script -R \
	--installable-package="${INSTALL_DIR}/swift-3.0" \
	--install-destdir="${INSTALL_DIR}/output" \
	--install-symroot="${INSTALL_DIR}/debug-output" \
	-- \
	--llvm-install-components="clang;clang-headers;libclang;libclang-headers" \
	--swift-install-components="compiler;stdlib;sdk-overlay;clang-builtin-headers;editor-integration;sourcekit-xpc-service" \
	--darwin-toolchain-name="swift-3.0" \
	--darwin_toolchain_display_name="local.swift.3" \
	--darwin_toolchain_bundle_identifier="local.swift.3" \
	--toolchain_prefix="swift3.xctoolchain" \
	--darwin_toolchain_alias="local" \
	--install-swift \
	--install-prefix="/usr" \
	--cross-compile-hosts="${TARGET}" \
	--cross-compile-sysroot="${SYSROOT}" \
	--cross-compile-toolchain-bin="${TOOLCHAIN}" \
	--reconfigure

