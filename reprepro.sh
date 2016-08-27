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

REPO_ROOT=/tank/repo
sudo reprepro -b $REPO_ROOT includedeb $CODENAME $PACKAGE
s3cmd --verbose --acl-public --delete-removed sync $REPO_ROOT/ s3://iachievedit-repos/
