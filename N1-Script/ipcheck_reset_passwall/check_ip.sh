#!/bin/bash

cd /root/ipcheck_reset_passwall

#time_file="./reboot_time.ini"
list_dir="./list"
name_list_file="./name_list.ini"
flag_file="$list_dir/reboot_flag"
dnsname="223.6.6.6"
rb="reboot.sh"
rst="reset_haproxy.sh"

name_list=`cat $name_list_file`
flag=`cat $list_dir/reboot_flag`
#time_reboot=`cat $time_file`

date "+%Y-%m-%d %H:%M:%S"
#echo "namelist: $name_list"
echo "reboot flag: $flag"
#echo "reboot time: $time_reboot:00:00"

for i in $name_list; do
	tmp=$i
	#echo $tmp
	if [ "$flag" = "0" ]; then
		old=`cat $list_dir/$tmp.ip`
		new=`nslookup $tmp $dnsname|grep -v $dnsname|grep "Address" |awk '{print $3}'`
		#echo "old:$old, new:$new"	
		#if [ ! -n "$old" ] || [ "$old" != "$new" ] ;then
		if [ ! -n "$old" ] ;then
			echo $new >$list_dir/$i.ip
		elif [ "$old" != "$new" ] ;then
			echo "1" >$flag_file
			echo $new >$list_dir/$i.ip
			old2=$old
			new2=$new
		fi
	
		#echo -e "$i: `cat $list_dir/$i.ip`"
	#else
		#echo -e "need reboot at time: $time_reboot"
		#./$rb $time_reboot
		#echo -e "reset haproxy..."
		#./$rst
		#echo "0" >$flag_file
	fi
done

flag1=`cat $list_dir/reboot_flag`
if [ "$flag1" = "1" ]; then
	echo "old:$old2, new:$new2"
	echo -e "reset passwall..."
	./$rst
	echo "0" >$flag_file
else
	echo "nothing todo..."
fi

