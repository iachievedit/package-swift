#!/bin/sh
git clone https://github.com/apple/swift.git swift --depth=1
git clone https://github.com/apple/swift-llvm.git llvm --depth=1
git clone https://github.com/apple/swift-clang.git clang --depth=1
git clone https://github.com/apple/swift-lldb.git lldb --depth=1
git clone https://github.com/apple/swift-cmark.git cmark --depth=1
git clone https://github.com/apple/swift-llbuild.git llbuild --depth=1
git clone https://github.com/apple/swift-package-manager.git swiftpm --depth=1
git clone https://github.com/apple/swift-corelibs-xctest.git --depth=1
git clone https://github.com/apple/swift-corelibs-foundation.git --depth=1
git clone https://github.com/apple/swift-integration-tests swift-integration-tests --depth=1
