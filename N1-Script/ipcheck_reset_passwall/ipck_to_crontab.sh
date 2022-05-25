#!/bin/bash

touch /tmp/tmp/check.log
touch /tmp/check_crontab.log
while true
do
        ck=`cat /etc/crontabs/root |grep check_ip.sh`
        if [ "$ck" == "" ];then
                echo "*/5 * * * * /root/ipcheck_reset_passwall/check_ip.sh >>/tmp/check.log" >>/etc/crontabs/root
        else
                echo "nothing todo." >>/tmp/check_crontab.log
        fi
        sleep 600
        date "+%Y-%m-%d %H:%M:%S" >>/tmp/check_crontab.log
done

