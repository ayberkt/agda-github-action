#!/bin/sh -l

echo "Main file: $1"
echo "Source directory: $2"
agda --version
time=$(date)
echo "::set-output name=time::$time"
