#!/bin/bash
# Copyright 2016 iAchieved.it LLC
# MIT License (https://opensource.org/licenses/MIT)
for dir in clang cmark compiler-rt crosscompile_support llbuild lldb \
llvm swift swift-corelibs-foundation swift-corelibs-libdispatch \
swift-corelibs-xctest swift-integration-tests swiftpm ; do
  echo "Revert local changes in $dir"
  pushd $dir > /dev/null
  git stash save --keep-index
  git stash drop
  popd > /dev/null
done

for dir in `ls patches/armv7/`; do
  for file in `ls patches/armv7/$dir/`; do
    echo "Applying patch $dir/$file"
    pushd $dir 
    git apply ../patches/armv7/$dir/$file
    popd
  done
done
