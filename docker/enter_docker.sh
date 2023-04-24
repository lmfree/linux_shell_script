#!/bin/bash

#echo $#
if [ $# -le 0 ]; then
	echo -e "please input docker name"
	exit 0
fi

name=$1

docker exec -it `docker ps|grep "$name" |awk '{print $1}'` /bin/bash
[ $? -ne 0 ] && docker exec -it `docker ps|grep "$name" |awk '{print $1}'` /bin/sh

