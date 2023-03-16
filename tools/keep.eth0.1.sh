#!/bin/bash

echo -n $(date "+%Y-%m-%d %H:%M:%S")" "

eth_name="eth0:1"
ipaddr="192.168.30.3"

ck=$(ifconfig |grep $eth_name)

#echo -e "check eht->$eth_name result: $ck"

if [ "$ck" = "" ];then
	echo -e "will to add $eth_name"
	ifconfig $eth_name $ipaddr
else
	echo -e "nothing todo..."
fi
