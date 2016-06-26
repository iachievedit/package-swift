#!/bin/bash
git clone https://github.com/apple/swift.git swift
./swift/utils/update-checkout --clone
rm -rf swift-corelibs-libdispatch
git clone https://github.com/hpux735/swift-corelibs-libdispatch swift-corelibs-libdispatch
cd swift-corelibs-libdispatch
git submodule init
git submodule update
cd ..
