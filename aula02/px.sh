#!/bin/bash

for i in $*; do
    chmod u+x $i
done

echo "Todos os ficheiros agora têm permissões"