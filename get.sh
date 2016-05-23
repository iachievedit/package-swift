#!/bin/bash
git clone --branch swift-2.2-branch https://github.com/apple/swift
./swift/utils/update-checkout --clone --branch swift-2.2-branch
ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  rm -rf llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm 
fi
