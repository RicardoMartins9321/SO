#!/bin/bash

function compare()
{
    if [ $1 -gt $2 ]; then
        echo "$1 is greater than $2"
    elif [ $1 -lt $2 ]; then
        echo "$1 is less than $2"
    else
        echo "$1 is equal to $2"
    fi
    return 0
}

compare