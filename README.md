How to create APT repository
* Put .deb file somewhere
* Create an ascii armored gpg key
    * `gpg --full-gen-key`
    * `gpg --armor --export "max.mustermann@gmail.com" > ./KEY.gpg`
* `mkdir -p ./dists/bullseye/main/binary-amd64`
* `apt-ftparchive generate ./apt-ftparchive.conf`
* `apt-ftparchive release -c ./apt-ftparchive.conf ./dists/bullseye/ > ./dists/bullseye/Release`
* `(cd ./dists/bullseye && gpg --default-key "max.mustermann@gmail.com" --armor --detach-sign --sign --output Release.gpg Release)`
* `(cd ./dists/bullseye && gpg --default-key "max.mustermann@gmail.com" --clearsign --output InRelease Release)`

On client side:
* `curl --silent --compressed "https://nqle.github.io/test_ppa/KEY.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/test-archive-keyring.gpg`

# Misc:
* `gpg --armor --export-secret-key 4FD36A1C > private.key`
* `gpg --armor --export "max.mustermann@gmail.com" > /tmp/home/dockerexchange/pub.key`
