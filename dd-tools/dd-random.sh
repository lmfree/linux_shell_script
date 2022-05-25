#!/bin/bash

if [ $# != 2 ];then
	echo -e "\nneed 2 parameter, outfile and count(K)"
	exit 1
fi

echo -e "\n"

dd if=/dev/urandom of=$1 bs=1024 count=$2

echo -e "\ndone\n"
ls -lh $1
echo -e "\n"

