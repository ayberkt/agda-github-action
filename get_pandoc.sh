#!/bin/bash

curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
| grep "browser_download_url.*amd64.deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
dpkg -i *amd64.deb