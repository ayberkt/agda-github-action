#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
cd $2
git clone https://github.com/agda/cubical.git
mv cubical/Cubical .
agda --safe $1 || exit 1
agda --html $1 && mv html ..
