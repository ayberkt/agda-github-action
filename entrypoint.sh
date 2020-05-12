#!/bin/sh -l

echo "Main file: $1"
agda --version
time=$(date)
echo "::set-output name=time::$time"
