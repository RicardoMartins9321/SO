#!/bin/bash
# For all files in a folder, add or remove "new_" prefix
case $1 in
    -r)
        for f in $2/new_*; do
            mv "$f" "$2/$(basename $f | sed 's/^new_//')"
        done
        ;;
    *)
        for f in $1/*; do
            mv "$f" "$1/new_$(basename $f)"
        done
        ;;
esac
