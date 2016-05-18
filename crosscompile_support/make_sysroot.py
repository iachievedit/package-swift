#!/usr/bin/env python

import argparse
import sys
import gzip
import urllib
import urlparse
import posixpath
import cStringIO
import os
import subprocess


def get_packages_list(args):
    filename = "Packages.gz"
    filepath = cachedir + "/" + filename
    if not os.path.isfile(filepath):
        url = mirror + \
            "/dists/%s/main/binary-%s/%s" % (args.version, args.arch, filename)
        print "Retrieving:", url
        urllib.urlretrieve(url, filepath)
    io = gzip.open(filepath, 'r')

    packages = dict()
    curPackage = None
    i = 0

    print "Processing:", filepath
    for line in io.readlines():
        if len(line) == 1 and line[0] == '\n':
            curPackage = None
            continue

        try:
            key, value = line.rstrip().split(": ", 1)
        except:
            continue
        if curPackage is None:
            assert key == "Package"
            curPackage = dict()
            packages[value] = curPackage
        else:
            curPackage[key] = value
    io.close()

    return packages


def urlAndNameFromPackage(p):
    url = mirror + "/" + p['Filename']
    name = posixpath.basename(urlparse.urlparse(url).path)
    return (url, name)


parser = argparse.ArgumentParser(prog='make_sysroot',
                                 description="""Create a sysroot to use when cross-compiling things.
  e.g. to make an Ubuntu 14.04 armhf sysroot run:
    make_sysroot.py --distro ubuntu --version trusty --arch armhf --install <destination sysroot>
  e.g. to make a Debian Jessie armel sysroot run:
    make_sysroot.py --distro debian --version jessie --arch armel --install <destination sysroot>"""
                                 )
parser.add_argument('--distro', required=True, help='Distribution')
parser.add_argument('--version', required=True, help='Version')
parser.add_argument('--arch', required=True, help='Architecture')
parser.add_argument('--install', help='Install dir')


args = parser.parse_args(sys.argv[1:])


required_packages = [
    'libc6',
    'libc6-dev',
    'linux-libc-dev',
    'libicu52',
    'libicu-dev',
    'libbsd0',
    'libbsd-dev',
    'libgcc-4.8-dev',
    'libstdc++-4.8-dev',
    'libstdc++6',
    'libstdc++-4.8-dev',
    'libatomic1',
    'libgcc1',
    'libxml2',
    'libxml2-dev',
    'libuuid1',
    'uuid-dev',
    'libncurses5',
    'libncurses5-dev',
    'libtinfo5',
    'libtinfo-dev',
    'zlib1g',
    'zlib1g-dev',
    'libedit2',
    'libedit-dev',
    'python-dev',  # for LLDB
    'libsqlite3-0',  # for LLBuild
    'libsqlite3-dev'  # for LLBuild
]

mirror = ""
if args.distro == "ubuntu":
    mirror = "http://ports.ubuntu.com/ubuntu-ports"
elif args.distro == "debian":
    mirror = "http://ftp.debian.org/debian"
elif args.distro == "raspbian":
    mirror = "http://archive.raspbian.com/raspbian"
else:
    sys.exit(1)

cachedir = "cache/%s/%s" % (args.distro, args.version)
if not os.path.exists(cachedir):
    os.makedirs(cachedir)

all_packages = get_packages_list(args)

deps = []

for name in required_packages:
    p = all_packages[name]
    url, filename = urlAndNameFromPackage(p)
    if p.has_key("Depends"):
        for d in p['Depends'].split(', '):
            deps.append(d)
    filepath = cachedir + "/" + filename
    if not os.path.isfile(filepath):
        print "Retrieving:", url
        urllib.urlretrieve(url, filepath)

    if args.install:
        print "Installing:", filepath
        ret = subprocess.call(['dpkg-deb', '-x', filepath, args.install])
        assert ret == 0


# Fixup broken symlinks
if args.install:
    for dirname, dirnames, filenames in os.walk(args.install):
        for filename in filenames:
            path = os.path.join(dirname, filename)
            if os.path.islink(path):
                link = os.readlink(path)
                if link[0] == os.path.sep:
                    fulllink = os.path.normpath(
                        os.path.join(args.install, "." + link))
                    fixed = os.path.relpath(fulllink, dirname)
                    os.unlink(path)
                    os.symlink(fixed, path)