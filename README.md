# package-swift
A set of helper scripts for building and packaging Swift 4.0 on Ubuntu Linux

See companion instructions at http://dev.iachieved.it/iachievedit/keeping-up-with-open-source-swift/

Before executing any scripts will you want to have all of the build prerequisites installed:

```
sudo apt-get install git cmake ninja-build clang uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config autoconf libtool systemtap-sdt-dev libcurl4-openssl-dev
```

Usage:

```
./get.sh to initially populate the directory with the Swift 4.0 repositories from Github
./package.sh to build and package everything
./update.sh to refresh your source code with the latest from Github
./clean.sh to delete the build and install directory
./distclean.sh to delete everything except the helper scripts
```

Internally I use ```packagedeb.sh``` to create an Debian package for 
distribution via a repository and ```apt-get```.

## Swift CI Build Status

The Swift continuous integration build server hosts _packaging_ jobs that build and package all of the Swift components for OS X, Ubuntu 14.04, 16.04, and 16.10.  If the `package.sh` script in this repository fails you may want to look at the current status of the canonical builds at https://ci.swift.org/view/Packages/.
