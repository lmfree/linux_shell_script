#!/bin/bash

cnt=`ps|grep fwd_tcp_map.py|grep -v grep|wc -l`
echo $cnt

if [ $cnt -gt 0 ];then
	pid=`ps|grep fwd_tcp_map.py|grep -v grep|awk '{print $1}'`
	echo "will to kill $pid"
	kill -s 9 $pid
	sleep 3
fi

./fwd_tcp_map.py www.gogfw.ga 2851 & >/dev/null

