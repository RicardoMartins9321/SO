#!/bin/bash

function compare()
{   
    echo "Introduza o primeiro numero"
    read NUM1
    echo "Introduza o segundo numero"
    read NUM2
    if [ "$NUM1" -gt "$NUM2" ]; then
        echo "$NUM1 is greater than $NUM2"
    elif [ "$NUM1" -lt "$NUM2" ]; then
        echo "$NUM1 is less than $NUM2"
    else
        echo "$NUM1 is equal to $NUM2"
    fi
    return 0
}

compare