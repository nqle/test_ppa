How to create APT repository
* Put .deb file somewhere
* Create an ascii armored gpg key
    * `gpg --full-gen-key`
    * `gpg --armor --export "max.mustermann@gmail.com" > /path/to/my_ppa/KEY.gpg`
* `apt-ftparchive packages . | tee ./dists/bullseye/main/binary-amd64/Packages | gzip -k -f > ./dists/bullseye/main/binary-amd64/Packages.gz`
* `apt-ftparchive release . > ./dists/bullseye/main/Release`
* `gpg --default-key "max.mustermann@gmail.com" --armor --detach-sign --sign --output ./dists/bullseye/main/Release.gpg ./dists/bullseye/main/Release`
* `gpg --default-key "max.mustermann@gmail.com" --clearsign --output ./dists/bullseye/main/InRelease ./dists/bullseye/main/Release`

On client side:
* `curl --silent --compressed "https://nqle.github.io/test_ppa/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/test-archive-keyring.gpg`
