#!/bin/bash
# Calculate the sum of a series of numbers.
SCORE="0"
SUM="0"
n="0"

while true; do
    echo -n "Enter your score [0-10] ('q' to quit): "
    read SCORE;
    if (("$SCORE" < "0")) || (("$SCORE" > "10")); then
        echo "Try again: "
    elif [[ "$SCORE" == "q" ]]; then
        echo "Sum: $SUM."
        if [[ $SUM == 0 ]]; then
        	echo "Media: 0"
        else 
        	echo "Media: $(($SUM/$n))."
        fi
    break
    else
        n=$(($n+1))
        SUM=$((SUM + SCORE))
    fi
done
echo "Exiting."

