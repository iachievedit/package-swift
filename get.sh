#!/bin/bash
git clone https://github.com/apple/swift.git swift
./swift/utils/update-checkout --clone
ARCH=`arch`
if [[ $ARCH =~ armv7 ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  rm -rf llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm 
fi
