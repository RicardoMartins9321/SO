#!/bin/bash
# select structure to create menus
PS3="Select a argument (1-oo): " 	# changes the system question '#?'

select arg in $@; do
    echo "You picked $arg ($REPLY)."
done
