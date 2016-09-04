#!/bin/sh
#
# 
cp -R swift-corelibs-libdispatch/dispatch/ install/usr/lib/swift

cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftdoc install/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftmodule install/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/libdispatch.la install/usr/lib/swift/linux/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/.libs/libdispatch.so install/usr/lib/swift/linux

mkdir -p install/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/linux_base.h install/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/object.h install/usr/lib/swift/os

# Retar
tar -C install -czvf swift.tar.gz .
