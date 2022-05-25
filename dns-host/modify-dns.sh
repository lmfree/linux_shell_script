#!/bin/bash
dir=/root/dns-host
dns_name="lmfree.vip"
ping $dns_name -c 1 >$dir/ping.log
ip=`cat $dir/ping.log |grep from |awk -F":" '{print $1}'|awk '{print $4}'`
ip2=`cat /etc/hosts|grep synology |awk '{print $1}'`

date "+%Y-%m-%d %H:%M:%S"
echo -e "$dns_name ip: $ip, host ip:$ip2"

if [ $ip != $ip2 ]; then
	sed -i '/synology.lmfree.top/d' /etc/hosts
	echo "$ip synology.lmfree.top" >>/etc/hosts
	rm -f $dir/ping.log
	echo -e "\nhost:"
	cat /etc/hosts|grep synology
else
	echo -e "$dns_name ip not change."
fi
