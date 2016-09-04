#!/bin/bash
#
# 
pushd `dirname $0` > /dev/null
WHERE_I_AM=`pwd`
ARCH=`arch`
popd > /dev/null
INSTALL_DIR=${WHERE_I_AM}/install
PACKAGE=${WHERE_I_AM}/swift.tar.gz

cp -R swift-corelibs-libdispatch/dispatch/ ${INSTALL_DIR}/usr/lib/swift

cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftdoc ${INSTALL_DIR}/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftmodule ${INSTALL_DIR}/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/libdispatch.la ${INSTALL_DIR}/usr/lib/swift/linux/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/.libs/libdispatch.so ${INSTALL_DIR}/usr/lib/swift/linux

mkdir -p ${INSTALL_DIR}/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/linux_base.h ${INSTALL_DIR}/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/object.h ${INSTALL_DIR}/usr/lib/swift/os

# Retar
tar -C ${INSTALL_DIR} -czvf ${PACKAGE} .
