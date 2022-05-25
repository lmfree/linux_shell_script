#!/bin/bash

help_str="please input: $0 file"

if [ -z "$1" ] ; then
	echo -e "\t$help_str"
	exit
fi

sync_file=$1

dst_computer="192.168.127.196:/home/liming 192.168.127.199:/home/liming 192.168.127.192:/home/liming"

for i in $dst_computer 
do
	echo "sync to: $i"
	rsync -avh $sync_file $i
done


