#!/bin/bash
cnts=`ps -elf|grep rslsync|grep sync.conf|wc -l`
if [ $cnts -eq 0 ];then
        date "+%Y-%m-%d %H:%M:%S"
        echo -e "restart rslsync..."
        /usr/local/resiliosync/bin/rslsync --config /usr/local/resiliosync/var/sync.conf
else
        echo -e "nothing todo..."
fi

