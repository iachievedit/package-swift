#!/bin/bash
ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, remove hpux735 LLVM"
  rm -rf llvm
fi
./swift/utils/update-checkout
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  rm -rf llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm
fi
