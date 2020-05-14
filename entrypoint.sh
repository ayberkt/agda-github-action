#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
cd $2
mkdir agda-dir

# Pull the standard library.
wget https://github.com/agda/agda-stdlib/archive/v1.3.tar.gz
tar -xf v1.3.tar.gz
mv agda-stdlib-1.3 agda-dir

# Pull the cubical library.
git clone https://github.com/agda/cubical.git
mv cubical agda-dir

echo "standard-library"                                          >  agda-dir/defaults
echo "cubical"                                                   >> agda-dir/defaults
echo "$(pwd)/agda-dir/agda-stdlib-1.3/standard-library.agda-lib" >  agda-dir/libraries
echo "$(pwd)/agda-dir/cubical/cubical.agda-lib"                  >> agda-dir/libraries

export AGDA_DIR=$(pwd)/agda-dir

if [ "$3" = "true" ]; then
    echo "Running Agda in unsafe mode."
    agda $1 || exit 1
else
    echo "Running Agda in safe mode."
    agda --safe $1 || exit
fi

agda --html $1
