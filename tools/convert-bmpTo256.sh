#!/bin/bash

helpstr="please input src bmp filename\n\t$0 xx.bmp"

if [ "$1" == "" ];then
	echo -e "$helpstr"
else
	in=$1
	#out=`echo $in |cut -d . -f-1`_256.bmp
	out=`echo $in|sed 's/\.[^.]*$//'`_to256color.bmp

	convert -compress rle -colors 256 $in $out
fi

