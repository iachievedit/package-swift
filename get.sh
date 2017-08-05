#!/bin/bash
# Copyright 2016 iAchieved.it LLC
# MIT License (https://opensource.org/licenses/MIT)
BRANCH=swift-4.0-branch
git clone https://github.com/apple/swift.git -b $BRANCH swift
ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  ./swift/utils/update-checkout --branch $BRANCH --clone --skip-repository llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm 
else
  ./swift/utils/update-checkout --clone #--branch $BRANCH
fi
