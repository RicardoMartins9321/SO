#!/bin/bash
#This script opens 4 terminal windows.
i="0"
for num in {1..4}; do
    xterm &
    i=$(($i+1))
done
