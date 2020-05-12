#!/bin/sh -l

echo "Main file: $1"
time=$(date)
echo "::set-output name=time::$time"
