#!/bin/bash
# Copyright 2016 iAchieved.it LLC
# MIT License (https://opensource.org/licenses/MIT)
for dir in `ls patches/armv7/`; do
  for file in `ls patches/armv7/$dir/`; do
    echo "Applying patch $dir/$file"
    pushd $dir 
    git apply ../patches/armv7/$dir/$file
    popd
  done
done
