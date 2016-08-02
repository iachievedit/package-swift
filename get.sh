#!/bin/bash
git clone https://github.com/apple/swift.git swift
ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  ./swift/utils/update-checkout --clone --skip-repository llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm 
else
  ./swift/utils/update-checkout --clone
fi
