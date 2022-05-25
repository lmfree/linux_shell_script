#!/bin/bash

touch /tmp/check_crontab.log
while true
do
        ck=`cat /etc/crontabs/root |grep frpc`
        if [ "$ck" == "" ];then
                echo "1 hour to restart frpc " >>/tmp/check_crontab.log
                echo "*/120 * * * * /root/frpc/rs.sh" >>/etc/crontabs/root
        else
                echo "nothing todo." >>/tmp/check_crontab.log
        fi
        sleep 600
        date "+%Y-%m-%d %H:%M:%S" >>/tmp/check_crontab.log
done

