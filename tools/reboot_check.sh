#!/bin/bash

dns=www.baidu.com
port=443
tmpf=/root/.reboot-check-tmp.log
boundary=5
reboot_logf=/root/.reboot.log

/root/net-check.sh $dns $port &>/dev/null
ret=$?

if [ ! -f $tmpf ];then
	echo -e "create tmp file --> $tmpf"
	touch $tmpf
	echo -n "0" >$tmpf
fi

cnt=`cat $tmpf |xargs echo -n`
echo -e "cur cnt: $cnt"

echo -e "check \"$dns\" result: $ret"
if [ $ret -eq 0 ];then
	echo -n "0" >$tmpf
else
	#cnt=`cat $tmpf |xargs echo -n`
	((cnt=cnt+1))
	echo "cnt=$cnt"
	echo -n "$cnt" >$tmpf
fi

[ -f $reboot_logf ] || touch $reboot_logf

if [ $cnt -gt $((boundary+10)) ];then
	echo -n `date "+%Y-%m-%d %H:%M:%S"` >>$reboot_logf
	echo -e "reboot force" >>$reboot_logf
	reboot -nf
fi

if [ $cnt -gt $boundary ];then
	echo -n `date "+%Y-%m-%d %H:%M:%S"` >>$reboot_logf
	echo -e "reboot" >>$reboot_logf
	reboot
fi

