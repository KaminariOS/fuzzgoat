#!/usr/bin/env bash

for filename in ./out/default/crashes/id*; do
    echo "$filename"
    ./fuzzgoat "$filename" &> ./err/"$(basename "$filename")"
    # rg ERROR "$filename" &> ./err/"$(basename "$filename")"
done
