#!/bin/bash

# script must be executed from root of the archive
# .deb files must be located in a 'pool' subdirectory at the root of the archive

set -eux

DIST=bullseye
EMAIL=max.mustermann@gmail.com
ARCH=amd64
COMPONENT=main

echo "Dir::ArchiveDir ".";

BinDirectory \"pool\" {
    Packages \"dists/${DIST}/${COMPONENT}/binary-${ARCH}/Packages\";
}

APT::FTPArchive::Release::Origin \"Quy\";
APT::FTPArchive::Release::Label \"test apt repo\";
APT::FTPArchive::Release::Suite \"${DIST}\";
APT::FTPArchive::Release::Codename \"${DIST}\";
APT::FTPArchive::Release::Architectures \"${ARCH}\";
APT::FTPArchive::Release::Components \"${COMPONENT}\";
" > ./apt-ftparchive.conf

mkdir -p ./dists/${DIST}/${COMPONENT}/binary-${ARCH}

apt-ftparchive generate ./apt-ftparchive.conf

apt-ftparchive release -c ./apt-ftparchive.conf ./dists/${DIST}/ > ./dists/${DIST}/Release
(cd ./dists/${DIST} && gpg --default-key "${EMAIL}" --armor --detach-sign --sign --output Release.gpg Release)
(cd ./dists/${DIST} && gpg --default-key "${EMAIL}" --clearsign --output InRelease Release)
