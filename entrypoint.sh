#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
cd $2
agda --safe $1
time=$(date)
echo "::set-output name=time::$time"
