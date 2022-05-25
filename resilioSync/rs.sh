#!/bin/bash
cd /home/lmfree2000/resilioSync
cnts=`ps -elf|grep rslsync|wc -l`
if [ $cnts -ne 1 ];then
	pid=`ps -elf|grep rslsync|grep listen|awk '{print $4}'`
	echo -e "cur pid: $pid"
	kill $pid
	sleep 8
fi

./start_with_ui_port.sh

