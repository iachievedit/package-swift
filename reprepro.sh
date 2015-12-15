#!/bin/sh
REPO=$1
sudo reprepro -b /tank/repo/$REPO includedeb $REPO swift-2.2.deb
s3cmd --verbose --acl-public --delete-removed sync /tank/repo/$REPO/ s3://iachievedit-$REPO/                         
