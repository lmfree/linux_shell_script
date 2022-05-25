#!/bin/bash
help="\n$0 [size(k)] [filename]\n"
echo -e $help

blk=64
file=out_0xff.bin
#echo -e "$#, $1, $2"

if [ -f $file ]
then
	rm $file
fi

if [ $# -eq 1 ]
then
	blk=$1
fi

if [ $# -eq 2 ]
then
	blk=$1
	file=$2
	if [ -f $file ]
	then
		rm $file
	fi
fi

#echo -e "blk=$blk"

k=1024
((n=k*blk))
echo "n=$n --> $file"

while [ $n -ne 0 ]
do
	echo -e '\0377\c' >> $file
	((n=n-1))
done

