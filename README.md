How to create APT repository
* Put .deb file somewhere
* Create an ascii armored gpg key
    * `gpg --full-gen-key`
    * `gpg --armor --export "max.mustermann@gmail.com" > /path/to/my_ppa/KEY.gpg`
* `apt-ftparchive generate ./apt-ftparchive.conf`
* `apt-ftparchive release -c ./apt-ftparchive.conf ./dists/buster/ > ./dists/buster/Release`
* `(cd ./dists/buster && gpg --default-key "max.mustermann@gmail.com" --armor --detach-sign --sign --output Release.gpg Release)`
* `(cd ./dists/buster && gpg --default-key "max.mustermann@gmail.com" --clearsign --output InRelease Release)`

On client side:
* `curl --silent --compressed "https://nqle.github.io/test_ppa/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/test-archive-keyring.gpg`
