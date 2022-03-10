#!/bin/bash

# This script will generate the python script for ansible dynamic inventory
inventory_template=inventory.py
#file=/tmp/${1}.py
file=${1}.py
if test -f "$inventory_template"
then
    if /bin/cp $inventory_template $file && /bin/sed -i "s/host_ip/$2/g" $file
    then
        exit 0
		#echo "0"
    else
        exit 1
		#echo "1"
	fi
else
    exit 1
	#echo "1.1"
fi
#return
