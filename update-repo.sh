#!/bin/bash

# script must be executed from root of the archive, where apt-ftparchive.conf should also be located
# .deb files must be located in a 'pool' subdirectory at the root of the archive

set -eux

DIST=bullseye
EMAIL=max.mustermann@gmail.com

mkdir -p ./dists/${DIST}/main/binary-amd64

apt-ftparchive generate ./apt-ftparchive.conf

apt-ftparchive release -c ./apt-ftparchive.conf ./dists/${DIST}/ > ./dists/${DIST}/Release
(cd ./dists/${DIST} && gpg --default-key "${EMAIL}" --armor --detach-sign --sign --output Release.gpg Release)
(cd ./dists/${DIST} && gpg --default-key "${EMAIL}" --clearsign --output InRelease Release)
