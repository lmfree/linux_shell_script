#!/bin/bash
cd /home/liming/forward

json_f="start.sh"

#modify(min, max, dns_name)
function modify(){
	port_min=$1
	port_max=$2
	dns_name=$3

	port=`cat $json_f |grep $dns_name |grep -v 22 |awk '{print $4}'`
	port_org=$port
	echo $port_org

	cat $json_f |grep $port_org|wc -l

	if [ $port_org -ge $port_max ];then
        port=$port_min
	elif [ $port_org -lt $port_min ];then
        port=$port_min
	else
        ((port=$port+1))
	fi

	echo $port

	sudo sed -i "s/$dns_name $port_org/$dns_name $port/g" $json_f
}

#------------------------------------------
g_port_max=2850
g_port_min=2700
g_dns_name="sp.lmfree.cn"
modify $g_port_min $g_port_max $g_dns_name

#------------------------------------------
g_port_max=3000
g_port_min=2851
g_dns_name="www.gogfw.ga"
modify $g_port_min $g_port_max $g_dns_name

#------------------------------------------
./stop.sh
./start.sh

cd -

