#!/bin/bash
if [ $# -ne 3 ];then
	echo -e "$0 src_port dst_ip dst_port"
else
	src_port=$1
	dst_port=$3
	dst_ip=$2
	cmd="socat TCP4-LISTEN:$src_port,reuseaddr,fork TCP4:$dst_ip:$dst_port"
	echo -e "$cmd"
	$cmd
fi

