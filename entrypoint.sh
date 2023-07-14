#!/bin/bash

echo "Main file: $1"
echo "Source directory: $2"
echo "HTML: $4"
agda --version
ghc --version
cabal --version

cd $2

if [ "$5" == true ]; then
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

if [ "$3" = "true" ]; then
    echo "Running Agda in unsafe mode."
    agda $1 || exit 1
else
    echo "Running Agda in safe mode."
    agda --safe $1 || exit
fi

if [ "$4" == "true" ]; then
    echo "Generating HTML from Agda code."
    agda --html --html-highlight=auto $1

    # Generate HTML from Markdown files.
    cd html
    for file in `ls *.md`; do
        title=$(basename -s .md $file)
        pandoc \
            --embed-resources \
            --standalone \
            --css=Agda.css \
            --metadata title=$title \
            -o $title.html \
            $file;
        rm $file
    done
    cd ..
fi
