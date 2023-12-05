#!/bin/bash
case $1 in
    [0-9][0-9])
     echo "$1 - Validado"
     ;;
    * )
     exit 1;
     ;;
esac

case $2 in 
    sec*)
     echo "$2 - Validado"
     ;;
    *)
     exit 1;
     ;;
esac