#!/bin/bash

workdir=/root/check-serv
logf=/tmp/emby.check.log
ck_flag_f=$workdir/emby.ck

date_str=$(date "+%Y-%m-%d %H:%M:%S")

d2=$(echo $date_str|awk '{print $1}')

<<COMMENT
if [ -f $logf ];then
	d1=$(tail $logf -n 1|awk '{print $1}')
	if [ "$d1" != "$d2" ];then
		echo -e "will rm $logf"
		rm $logf -f
	else
		echo -e "--> $d1 vs $d2"
	fi
fi
COMMENT

max_file_size=$((1024*1024))
if [ -f $logf ];then
	sizef=$(stat -c%s "$logf")
	echo -e "log file size: $sizef"
	if [ $sizef -gt $max_file_size ];then
		echo -e "will rm $logf,it exceed  max file size. (>$(($max_file_size/1024))K )"
		rm -f $logf
	fi
fi

echo $date_str >>$logf

nc -z 192.168.30.3 8096
echo $? >$ck_flag_f

sleep 1
result=`cat $ck_flag_f`
echo -e "result: $result" >>$logf
if [ "$result" != "0" ];then
	echo -e "not 0" >>$logf
	if [ -f $workdir/already.send.mail ];then
		echo -e "already send mail to gmail, nothing todo." >>$logf 
	else
		echo "emby serv drop ... please restart it." | msmtp -a qqmail lmfree2000@gmail.com
		if [ "$?" = "0" ];then
			echo "send mail to gmail box" >$workdir/already.send.mail
			echo -e "create 'already.send.mail'" >>$logf
		fi		
	fi
else
	[ -f $workdir/already.send.mail ] && rm -f $workdir/already.send.mail
fi

echo -e "--------------------------\n" >>$logf
