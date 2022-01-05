How to create APT repository
* Put .deb file somewhere
* Create an ascii armored gpg key
    * `gpg --full-gen-key`
    * `gpg --armor --export "max.mustermann@gmail.com" > /path/to/my_ppa/KEY.gpg`
* `apt-ftparchive packages . | gzip -f > Packages.gz`
* `apt-ftparchive release . > Release`
* `gpg --default-key "max.mustermann@gmail.com" --armor --detach-sign --sign --output Release.gpg Release`
* `gpg --default-key "max.mustermann@gmail.com" --clearsign --output InRelease Release`
