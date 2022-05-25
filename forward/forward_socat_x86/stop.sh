#!/bin/bash
dir="/home/liming/forward"
if [ "$1" != "" ];then
	dir=$1
fi

cd $dir
cnts=`ps -elf|grep socat|grep -v grep|wc -l`
echo $cnts

if [ $cnts -eq 0 ]; then
	echo "not to kill"
else
	pid_lst=`ps -elf|grep socat|grep -v grep|awk '{print $4}'`
	echo -e "pid: $pid_lst"
	for i in $pid_lst
	do
		echo -e "while to kill $i"
		kill $i
		sleep 1
	done
fi
sleep 2
cd -

