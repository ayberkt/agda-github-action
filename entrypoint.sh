#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
cd $2
git clone https://github.com/agda/cubical.git
mv cubical/Cubical .
wget https://github.com/agda/agda-stdlib/archive/v1.3.tar.gz
tar -xvf v1.3.tar.gz
agda --library-file=v1.3/standard-library.agda-lib --safe $1 || exit 1
agda --library-file=v1.3/standard-library.agda-lib --html $1 && mv html ..
