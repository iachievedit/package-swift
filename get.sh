#!/bin/bash

set -e
set -x

git clone https://github.com/apple/swift.git swift
ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, checkout hpux735 LLVM"
  ./swift/utils/update-checkout --clone --skip-repository llvm
  git clone --branch arm https://github.com/hpux735/swift-llvm llvm 
else
  ./swift/utils/update-checkout --clone
fi

if [[ "$1" == "--android" ]]; then
  # The Android build depends on libicu.
  git clone https://github.com/SwiftAndroid/libiconv-libicu-android.git
  # Download a copy of the latest supported Android NDK.
  wget http://dl.google.com/android/repository/android-ndk-r12b-linux-x86_64.zip
  unzip android-ndk-r12b-linux-x86_64.zip
  rm android-ndk-r12b-linux-x86_64.zip
fi
