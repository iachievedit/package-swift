#!/bin/bash


# distro can be:  debian, raspbian or ubuntu
DISTRO="raspbian"

# version of distro
VERSION="jessie"

# arch to build for
ARCH="armhf"

while getopts ":d:v:a:" opt; do
  case $opt in
    d) DISTRO="$OPTARG"
    ;;
    v) VERSION="$OPTARG"
    ;;
    a) ARCH="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

#fetch the proper sysroot using script from karwa
echo "Fetching sysroot: sysroot.$ARCH.$DISTRO.$VERSION"
./crosscompile_support/make_sysroot.py --distro $DISTRO --version $VERSION --arch $ARCH --install ./crosscompile_support/sysroot

# cross compiling requires changes from Karwa & armv6 changes from pj4533
git clone https://github.com/pj4533/swift.git swift

./swift/utils/update-checkout --clone

#compiler-rt caused issues
rm -rf compiler-rt