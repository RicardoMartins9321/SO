#!/bin/bash
# select structure to create menus
PS3="Select a argument (1-oo): "	# changes the system question '#?'

select arg in $@; do
	# switch case statement
    case $REPLY in 
        [1-$#])	# accepts all numbers the user provides
                echo "You picked $arg ($REPLY)."
            ;;
        * ) 	# if the user provides anything else output error
                exit 1;
            ;;
    esac
done
