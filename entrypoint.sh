#!/bin/bash

main_file=$1
source_dir=$2
unsafe=$3
generate_html=$4
standard_library=$5
css_link=$6

echo "Main file: $main_file"
echo "Source directory: $source_dir"
echo "HTML: $generate_html"
echo "CSS: $css_link"

agda --version
ghc --version
cabal --version

cd $source_dir

if [ "$standard_library" == true ]; then
    echo "Setting up the standard library"

    # Pull and install the standard library.
    mkdir agda-dir
    wget https://github.com/agda/agda-stdlib/archive/refs/tags/v2.3.tar.gz -O agda-stdlib-2.3.tar.gz
    tar -xf agda-stdlib-2.3.tar.gz
    mv agda-stdlib-2.3 agda-dir

    echo "standard-library"                                          >  agda-dir/defaults
    echo "$(pwd)/agda-dir/agda-stdlib-2.3/standard-library.agda-lib" >  agda-dir/libraries
    export AGDA_DIR=$(pwd)/agda-dir
else
  echo "Not setting up the standard library."
fi

if [ "$unsafe" = "true" ]; then
    echo "Running Agda in unsafe mode."
    agda $main_file || exit 1
else
    echo "Running Agda in safe mode."
    agda --safe $main_file || exit
fi

mkdir html
./admin-utilities/agda-html.py --typetopology . --css assets/Agda.css --out html


echo "Creating symlinks of HTML files..."
../admin-utilities/create_html_copies
