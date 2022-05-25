#!/bin/bash

modify_file="/etc/init.d/ssrs"
#modify_file="./ssrs"
#modify(min, max, dns_name)
function modify(){
        port_min=$1
        port_max=$2
        dns_name=$3

        #port=`cat $modify_file |grep $dns_name |grep -v 22 |awk '{print $4}'`
	port=`cat $modify_file |grep $dns_name |awk -F":" '{print $4}'|awk -F"\"" '{print $1}'`
        port_org=$port
        echo $port_org

        cat $modify_file |grep $port_org|wc -l

        if [ $port_org -ge $port_max ];then
        port=$port_min
        elif [ $port_org -lt $port_min ];then
        port=$port_min
        else
        ((port=$port+1))
        fi

        echo $port

        sed -i "s/$dns_name:$port_org/$dns_name:$port/g" $modify_file
}

#------------------------------------------
g_port_max=2850
g_port_min=2700
g_dns_name="sp.lmfree.cn"
modify $g_port_min $g_port_max $g_dns_name

/etc/init.d/ssrs restart

