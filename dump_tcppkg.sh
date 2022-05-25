#!/bin/bash
ck=`find /tmp -name "*.pcap"`
if [ "$ck" != "" ];then
	rm -v /tmp/*.pcap
	echo  'remove files in --> /tmp/*.pcap'
fi

file="/tmp/cap_lan$1.pcap"
echo -e "cap file name: $file, option: $2"
tcpdump -i br-lan $2 -s 0 -w $file

