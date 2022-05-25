#!/bin/bash

date "+%Y-%m-%d %H:%M:%S"
pid=`ps -elf|grep rslsync|grep sync.conf|awk '{print $4}'`

if [ "$pid" != "" ]; then
        echo -e "kill cur rslsync -> kill $pid"
        kill $pid
        sleep 5
fi

echo -e "restart rslsync..."
/usr/local/resiliosync/bin/rslsync --config /usr/local/resiliosync/var/sync.conf

