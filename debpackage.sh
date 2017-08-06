#!/bin/bash
#
# UBUNTU_VERSION is local and should increment 1...n
# UBUNTU_DISTRO  should be like trusty, xenial
function usage {
  echo "Usage:  UBUNTU_VERSION= UBUNTU_DISTRO= debpackage.sh"
  exit
}

if [ -z "$UBUNTU_VERSION" ]; then
  echo "UBUNTU_VERSION is not set"
  usage
fi

if [[ "$UBUNTU_DISTRO" =~ trusty ]]; then
  CLANG="clang-3.6"
else
  CLANG="clang (>= 3.6)"
fi

ARCH=${ARCH:-amd64}
PACKAGE_NAME=swift
PACKAGE_VERSION=4.0
PACKAGE_ROOT=${PACKAGE_NAME}-${PACKAGE_VERSION}
PACKAGE_DIR=${PACKAGE_ROOT}/opt/swift/swift-4.0

echo "Creating package for $ARCH"

rm -rf $PACKAGE_DIR
mkdir -p $PACKAGE_DIR
rsync -a install/usr/ ${PACKAGE_DIR}/usr/
ISIZE=`du -sb -B1024 ${PACKAGE_DIR}/usr/ |cut -f1`

echo "Estimated size is ${ISIZE} KB"

cp -R DEBIAN $PACKAGE_ROOT

# Remove extraneous /usr/local/, there is nothing in it
rm -rf $PACKAGE_DIR/usr/local

pushd swift > /dev/null
REV=`git rev-parse HEAD`
SWIFTREV=${REV:0:10}
popd > /dev/null

pushd llvm > /dev/null
REV=`git rev-parse HEAD`
LLVMREV=${REV:0:10}
popd > /dev/null

pushd clang > /dev/null
REV=`git rev-parse HEAD`
CLANGREV=${REV:0:10}
popd > /dev/null

pushd swift-corelibs-foundation > /dev/null
REV=`git rev-parse HEAD`
COREREV=${REV:0:10}
popd > /dev/null

# Replace control.in with control
pushd $PACKAGE_ROOT/DEBIAN > /dev/null
perl -p -e "s/##UBUNTU_VERSION##/${UBUNTU_VERSION}/g; s/##UBUNTU_DISTRO##/${UBUNTU_DISTRO}/g; s/##ARCH##/${ARCH}/g; s/##CLANG##/${CLANG}/g; s/##ISIZE##/${ISIZE}/g " control.in > control
#cp control.in control
cat << EOF >> control
 This is a packaged version of Open Source Swift $PACKAGE_VERSION built from
 the following git revisions of the Apple Github repositories:
       Clang:  $CLANGREV
        LLVM:  $LLVMREV
       Swift:  $SWIFTREV
  Foundation:  $COREREV
EOF

rm control.in
popd > /dev/null
fakeroot dpkg --build ${PACKAGE_ROOT}
