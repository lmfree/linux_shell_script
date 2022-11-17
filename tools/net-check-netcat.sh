#!/bin/sh

timeout=5
cmd=netcat
cmd='ping -w 2'

if [ $# -lt 2 ];then
        echo -e "please input [host] [port]\n"
else
        echo -e "will to check $1 $2"
        #$cmd -zv -w $timeout $1 $2
        $cmd $1
        ret=$?
        echo -e "end\n"
        exit $ret
fi
