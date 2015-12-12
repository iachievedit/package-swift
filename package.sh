#!/bin/sh
rm -rf /tmp/install /tmp/swift.tar.gz
./swift/utils/build-script --preset=buildbot_linux_1404 install_destdir=/tmp/install installable_package=/tmp/swift.tar.gz
