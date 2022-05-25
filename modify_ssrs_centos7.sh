#!/bin/bash

json_f="/etc/shadowsocks-r/config.json"
#json_f="a.json"
port_max=3000
port_min=2851

port=`cat $json_f |grep server_port|awk -F":" '{print $2}'|awk -F"," '{print $1}'`
echo $port
cat $json_f |grep $port|wc -l

port_org=$port

if [ $port_org -ge $port_max ];then
        port=$port_min
elif [ $port_org -lt $port_min ];then
        port=$port_min
else
        ((port=$port+1))
fi

echo $port

sudo sed -i "s/$port_org/$port/g" $json_f

sudo python /usr/local/shadowsocks/server.py -c $json_f -d restart

