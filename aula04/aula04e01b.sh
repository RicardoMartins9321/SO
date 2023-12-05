#!/bin/bash
function imprime_msg()
{
	echo "A minha primeira funcao"
	user=$(whoami)
	date=$(date)
	whereami=$(pwd)
	echo "You are currently logged in as $user and you are in the directory $whereami. 
Also today's date is $date"
	return 0
}

imprime_msg
