#!/bin/sh
CODENAME=$1
PACKAGE=$2
sudo reprepro -b /tank/repo/iachievedit includedeb $CODENAME $PACKAGE
s3cmd --verbose --acl-public --delete-removed sync /tank/repo/iachievedit/ s3://iachievedit-repos/
