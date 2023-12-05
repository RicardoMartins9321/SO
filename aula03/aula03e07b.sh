#!/bin/bash
# Calculate the sum of a series of numbers.
score="0"
sum="0"
n="0"

while true; do
    echo -n "Enter your score [0-10] ('q' to quit) ('r' to restart): "
    read score;
    if (("$score" < "0")) || (("$score" > "10")); then
        echo "Try again: "
    elif [[ "$score" == "q" ]]; then
        echo "Sum: $sum."
        if [[ $sum == 0 ]]; then
        	echo "Media: 0"
        else 
        	echo "Media: $(($sum/$n))."
        fi
    break
    elif [[ "$score" == "r" ]]; then
    	echo "The sum and score have been reseted to 0"
        sum="0"
        score="0"
        n="0"
    else
        n=$(($n+1))
        sum=$((sum + score))
    fi
done
echo "Exiting."

