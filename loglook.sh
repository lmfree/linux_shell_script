#!/bin/bash
echo -e "default to lookup 3 log file . ali, v2, web ...\n\t$0 [show lines(20)]"
lines=20
name="ali v2 web"

[ "$1" != "" ] && tmp=$1
[ -n "`echo $tmp|sed -n '/^[0-9][0-9]*$/p'`" ] && lines=$tmp

echo -e "\nwill to show $lines lines.\n"

for i in $name
do
	echo -e "*******************"
	echo -e "look log file: $i"
	echo -e "*******************"
	tail -n $lines /tmp/${i}-check-443.log
	echo -e "\n"
	read -n 1
done

