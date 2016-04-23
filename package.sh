#!/bin/bash
pushd `dirname $0` > /dev/null
WHERE_I_AM=`pwd`
ARCH=`arch`
popd > /dev/null
INSTALL_DIR=${WHERE_I_AM}/install
PACKAGE=${WHERE_I_AM}/swift.tar.gz
LSB_RELEASE=`lsb_release -rs  | tr -d .`
rm -rf $INSTALL_DIR $PACKAGE
if [[ $ARCH =~ armv7 ]]; then
echo "+ Building for ARM"
./swift/utils/build-script --preset=buildbot_linux_armv7 install_destdir=${INSTALL_DIR} installable_package=${PACKAGE}
else
echo "+ Building for x86"
./swift/utils/build-script --preset=buildbot_linux_${LSB_RELEASE} install_destdir=${INSTALL_DIR} installable_package=${PACKAGE}
fi
