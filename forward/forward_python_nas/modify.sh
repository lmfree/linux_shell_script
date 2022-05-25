#!/bin/bash

json_f="./start.sh"
port_max=3000
port_min=2851
dns_name='www.gogfw.ga'

cd /root/forward

port=`cat $json_f |grep $dns_name|awk '{print $3}'`
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

sed -i "s/$dns_name $port_org/$dns_name $port/g" $json_f

./$json_f

cd -
