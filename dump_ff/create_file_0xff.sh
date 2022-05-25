#!/bin/bash
file=out_0xff.bin
help_str="please input: \n\t$0 size(k), outfile is $file\n"
size=64
k=1024

rm -f $file
if [ "$1" = "" ] || [ "$1" = "help" ]
then
	echo -e "$help_str"
fi

if [ $# -gt 0 ]
then
	if [ "$1" != "help" ]
	then
		size=$1
		n=$((size * k))
		echo -e "debug: size-k:$size * $k = $n"
		while [ $n -ne 0 ]
		do
			echo -e '\0377\c' >> $file
			((n=n-1))
		done
		ls -l  $file
		ls -lh $file
	fi
fi

