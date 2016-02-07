#!/bin/sh
BRANCH=swift-2.2-branch
git clone --branch $BRANCH https://github.com/apple/swift.git swift
git clone --branch $BRANCH https://github.com/apple/swift-llvm.git llvm
git clone --branch $BRANCH https://github.com/apple/swift-clang.git clang
git clone --branch $BRANCH https://github.com/apple/swift-lldb.git lldb
git clone --branch $BRANCH https://github.com/apple/swift-cmark.git cmark
git clone --branch $BRANCH https://github.com/apple/swift-integration-tests swift-integration-tests
git clone https://github.com/apple/swift-llbuild.git llbuild
git clone https://github.com/apple/swift-package-manager.git swiftpm
git clone https://github.com/apple/swift-corelibs-xctest.git
git clone https://github.com/apple/swift-corelibs-foundation.git
