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
    wget https://github.com/agda/agda-stdlib/archive/v1.7.1.tar.gz
    tar -xf v1.7.1.tar.gz
    mv agda-stdlib-1.7.1 agda-dir

    echo "standard-library"                                            >  agda-dir/defaults
    echo "$(pwd)/agda-dir/agda-stdlib-1.7.1/standard-library.agda-lib" >  agda-dir/libraries
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

if [ "$generate_html" == "true" ]; then
    echo "Generating HTML from Agda code."
    if [ "$css_link" == "Agda.css" ]; then
        agda --html --html-highlight=auto $main_file
    else
        agda --html --html-highlight=auto --css=$css_link $main_file
    fi

    # Generate HTML from Markdown files.
    cd html
    for file in `ls *.md`; do
        title=$(basename -s .md $file)
        pandoc \
            --standalone \
            --css=$css_link \
            --metadata title=$title \
            -o $title.html \
            $file;
        rm $file
    done
    cd ..
fi
