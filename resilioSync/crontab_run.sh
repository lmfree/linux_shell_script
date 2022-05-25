#!/bin/bash
date "+%Y-%m-%d %H:%M:%S"
cnts=`ps -elf|grep rslsync|wc -l`
if [ $cnts -eq 1 ]; then
	echo 'start relsync server'
	cd /home/lmfree2000/resilioSync
	/home/lmfree2000/resilioSync/start_with_ui_port.sh
fi

