#!/bin/bash
CODENAME=$1
PACKAGE=$2

function usage {
  echo "Usage:    reprepro.sh CODENAME PACKAGE"
  echo "Example:  reprepro.sh jessie swift-2.2.deb"
  exit
}

if [ -z "$CODENAME" ]; then
  echo "CODENAME is not set"
  usage
fi

if [ -z "$PACKAGE" ]; then
  echo "PACKAGE is not set"
  usage
fi


sudo reprepro -b /tank/repo/iachievedit includedeb $CODENAME $PACKAGE
s3cmd --verbose --acl-public --delete-removed sync /tank/repo/iachievedit/ s3://iachievedit-repos/
