#!/bin/bash
dir="/home/liming/forward"
if [ "$1" != "" ];then
	dir=$1
fi

forward_cnt=6

cd $dir
#ps -elf|grep socat|grep -v grep|wc -l
cnts=`ps -elf|grep socat|grep -v grep|wc -l`
if [ $cnts -eq $forward_cnt ]; then
	echo -e "socat process $cnts == $forward_cnt, nothing todo!"
else
	echo -e "socat process $cnts != $forward_cnt, need to restart!"
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
	./socat_forward.sh 6632 sp.lmfree.cn 2701 &
	./socat_forward.sh 2000 ali.gogfw.ga 22 &
	./socat_forward.sh 2001 sp.lmfree.cn 22 &
	./socat_forward.sh 2002 set.gogfw.ga 22 &
	./socat_forward.sh 2004 192.168.127.1 443 &
	./socat_forward.sh 2600 www.gogfw.ga 2852 &
fi
cd -

