#!/bin/bash

logf=/tmp/emby.check.log

date_str=$(date "+%Y-%m-%d %H:%M:%S")

d2=$(echo $date_str|awk '{print $1}')

if [ -f $logf ];then
	d1=$(tail $logf -n 1|awk '{print $1}')
	if [ "$d1" != "$d2" ];then
		echo -e "will rm $logf"
		rm $logf -f
	else
		echo -e "--> $d1 vs $d2"
	fi
fi

echo $date_str >>/tmp/emby.check.log
workdir=/root/check-serv

nc -z 192.168.30.3 8096
echo $? >/root/check-serv/emby.ck

sleep 1
result=`cat emby.ck`
echo -e "result: $result"
if [ "$result" != "0" ];then
	echo -e "not 0"
	if [ -f $workdir/already.send.mail ];then
		echo -e "already send mail to gmail, nothing todo."
	else
		echo "emby serv drop ... please restart it." | msmtp -a qqmail lmfree2000@gmail.com --subject="nas emby server check"
		if [ "$?" = "0" ];then
			echo "send mail to gmail box" >$workdir/already.send.mail
			echo -e "create 'already.send.mail'"
		fi		
	fi
else
	echo -e "0"
	[ -f $workdir/already.send.mail ] && rm -f $workdir/already.send.mail
fi
