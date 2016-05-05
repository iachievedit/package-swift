#!/bin/bash
#
# This script is specifically for using with Jenkins at 
# http://swift-arm.ddns.net
#
INSTALL_DIR=${WORKSPACE}/install
TESTS=$1

./swift/utils/build-script -R $TESTS --lldb -- --install-swift --install-lldb --install-prefix=/opt/swift/swift-3.0/usr --install-destdir="$INSTALL_DIR" '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;sdk-overlay;license' --reconfigure

# preset style, we aren't using this right now
#ARCH=`arch`
#PACKAGE=${WORKSPACE}/swift.tar.gz
#LSB_RELEASE=`lsb_release -rs  | tr -d .`
#rm -rf $INSTALL_DIR $PACKAGE
#if [[ $ARCH =~ armv7 ]]; then
#echo "+ Building for ARM"
#echo ./swift/utils/build-script --preset=buildbot_linux_armv7 install_destdir="${INSTALL_DIR}" installable_package="${PACKAGE}"
#./swift/utils/build-script --preset=buildbot_linux_armv7 install_destdir="${INSTALL_DIR}" installable_package="${PACKAGE}"
#else
#echo "+ Building for x86"
#./swift/utils/build-script --preset=buildbot_linux_${LSB_RELEASE} install_destdir=${INSTALL_DIR} installable_package=${PACKAGE}
#fi
