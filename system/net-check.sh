#!/bin/bash
if [ $# -lt 2 ];then
	echo -e "please input [host] [port]\n"
else
	echo -e "will to check $1 $2"
	nc -zv -w 1 $1 $2
	ret=$?
	echo -e "end\n"
	exit $ret
fi

