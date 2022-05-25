#!/bin/bash
pid=`ps |grep frpc_d9 |grep conf|awk '{print $1}'`
if [ "$pid" != "" ];then
        echo will to kill $pid
        kill $pid
fi

#frpc_sp.conf
pid=`ps |grep frpc_sp |grep conf|awk '{print $1}'`
if [ "$pid" != "" ];then
        echo will to kill $pid
        kill $pid
fi

pid=`ps |grep frpc_dlovt |grep conf|awk '{print $1}'`
if [ "$pid" != "" ];then
       echo will to kill $pid                            
       kill $pid
fi

echo 'start d9 frpc'
/usr/bin/frpc -c /root/frpc/frpc_d9.conf &

echo 'start dlovt frpc'
/usr/bin/frpc -c /root/frpc/frpc_dlovt.conf &

echo 'start google vps sp frpc'
/usr/bin/frpc -c /root/frpc/frpc_sp.conf &

