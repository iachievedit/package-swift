#!/bin/bash
# Copyright 2016 iAchieved.it LLC
# MIT License (https://opensource.org/licenses/MIT)
BRANCH=swift-3.0-branch
echo "+ Reverting local changes"
for dir in clang cmark compiler-rt llbuild lldb \
llvm swift swift-corelibs-foundation swift-corelibs-libdispatch \
swift-corelibs-xctest swift-integration-tests swiftpm ; do
  echo "+ Revert local changes in $dir"
  pushd $dir > /dev/null
  git stash save --keep-index
  git stash drop
  popd > /dev/null
done

ARCH=`arch`
if [[ $ARCH =~ arm ]]; then
  echo "+ Building for ARM, skip repository llvm (we use hpux735/llvm)"
  ./swift/utils/update-checkout --branch $BRANCH --skip-repository llvm
  echo "+ git pull on hpux735/llvm"
  cd llvm && git pull
else
  ./swift/utils/update-checkout --branch $BRANCH
fi
