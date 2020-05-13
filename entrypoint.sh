#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
cd $2
wget https://github.com/agda/agda-stdlib/archive/v1.3.tar.gz
tar -xvf v1.3.tar.gz
mkdir /root/.agda
mv v1.3 /root/agda-stdlib
git clone https://github.com/agda/cubical.git
mv cubical/Cubical .
agda --safe $1 || exit 1
agda --html $1 && mv html ..
