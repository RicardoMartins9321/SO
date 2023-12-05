#!/bin/bash
# Conditional block if
if [[ $1 -gt 5 && $1 -lt 10 ]] ; then
	echo "Numero maior que 5 e menor que 10"
else
	echo "Numero menor que 5 ou maior que 10"
fi

