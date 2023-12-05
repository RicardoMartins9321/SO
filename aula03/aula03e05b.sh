#!/bin/bash
if [[ -d "$1" ]]; then
    for f in $1/*; do
        file "$f"
    done
else
    echo "Diretoria inexistente"
    exit 1;
fi
