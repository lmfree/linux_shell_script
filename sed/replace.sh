#!/bin/bash

if [ $# -gt 0 ];then
	input=$1
	len=${#input}
	#echo len:$len
	len=`expr $len - 4`
	#echo len:$len
	pre=${input:0:$len}_dot
	ext=${input:$len}
	file=$pre$ext
	#echo $file
	cp $input $file -v
	
	sed -i 's/  /,/g' $file
	sed -i 's/\r/,/g' $file

	sed -i 's/^\[/\/\/\[/g' $file
	sed -i 's/^Addr/\/\/Addr/g' $file
	sed -i 's/^,/\/\/,/g' $file
	cat $file
	echo -e "replace ' ' -> ',' to $file"
else
echo -e "please input filename."
fi


