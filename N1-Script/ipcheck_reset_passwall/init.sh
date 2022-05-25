#!/bin/bash

list_dir=./list
name_list_file=./name_list.ini
name_list=`cat $name_list_file`

mkdir -p $list_dir

for i in $name_list; do
	echo "">$list_dir/$i.ip
done

echo "0">$list_dir/reboot_flag

touch /tmp/ipcheck.log
