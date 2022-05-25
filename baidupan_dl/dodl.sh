#!/bin/bash

cnt=0

list_fname=link.baidu

if [ $# -ge 1 ];then
	list_fname=$1
fi

echo -e "\nwill to deal list file: $list_fname \n"
sleep 3

for i in `cat $list_fname`; 
do
	#echo -e "i-> $i"
	./bdown.sh "`echo $i|sed -e 's/\\n//g'`"
	((cnt++))
done

echo -e "dl file number: $cnt"

