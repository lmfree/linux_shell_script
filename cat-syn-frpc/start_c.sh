#!/bin/bash

mkdir -p /tmp/frpc
rm /tmp/frpc/frpc.log -f

cnts=`ps -elf|grep frpc|grep ini|wc -l`
echo $cnts
if [ $cnts -eq 1 ]; then
	pid=`ps -elf|grep frpc|grep ini|awk '{print $4}'`
	echo -e "kill frpc pid: $pid"
	kill $pid
	sleep 3
fi

./frpc -c frpc.ini &

sleep 1
cat /tmp/frpc/frpc.log

