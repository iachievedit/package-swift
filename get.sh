#!/bin/bash
#
# Copyright 2017 iAchieved.it LLC
# MIT License (https://opensource.org/licenses/MIT)
#

BRANCH=swift-4.0-branch

git clone https://github.com/apple/swift.git -b $BRANCH swift

ARCH=`arch`

if [[ $ARCH =~ arm ]]; then
  echo "+ Not currently supported for $ARCH"
else
  echo "+ Building for $ARCH"
  ./swift/utils/update-checkout --clone --scheme $BRANCH
fi
