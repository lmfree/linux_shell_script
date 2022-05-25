#!/bin/bash
cnts=`ps -elf|grep rslsync|grep sync.conf|wc -l`
if [ $cnts == 0 ];then
	echo -e "restart rslsync..."
	/usr/local/resiliosync/bin/rslsync --config /usr/local/resiliosync/var/sync.conf
else
	echo -e "nothing todo..."
fi

