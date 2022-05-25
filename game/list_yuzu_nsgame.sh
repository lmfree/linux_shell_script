#!/bin/bash

org_list_html_file=yuzu-game-list
[ -f $org_list_html_file ] && rm -f $org_list_html_file

#rm $org_list_html_file -fv

echo "para: $2"
if [ "$2" == "del" ];then
	rm $org_list_html_file -v
fi

if [ ! -f $org_list_html_file ];then
	curl https://yuzu-emu.org/game/ -o $org_list_html_file
fi

ck1=Perfect
ck2=Great
ck3=Okay
ck4=Bad
ck5="Intro/Menu"
ck6="Won't Boot"
ck7="Not Tested"

echo -e "\n\t$0 [1->$ck1,2->$ck2,3->$ck3,4->$ck4 or GameName]"

type=$ck1
name=''

if [ $# -gt 0 ]; then
	flg=`echo $1 |grep '[^0-9]' >/dev/null && echo no`
	#echo f:$flg
	if [ "$flg" = "no" ];then
		name=$1
	else
		if [ $1 -eq 1 ]; then
			type=$ck1
		elif [ $1 -eq 2 ]; then
			type=$ck2
		elif [ $1 -eq 3 ]; then
			type=$ck3
		elif [ $1 -eq 4 ]; then
			type=$ck4
		fi
	fi
fi

echo -e "\ttype: $type, name: $name, check file: $org_list_html_file\n\n"

title_list=`cat $org_list_html_file |grep "td data-title"`

old_ifs=$IFS
IFS=$'\n'
#echo "$IFS"|od -b

for i in $title_list
do
	rel=''
	gname=`echo "$i" |awk -F'"' '{print $2}'`
	#echo ==$game, $i

	if [ -z $name ];then
		line=`grep -F -n -m 1 ">$gname" $org_list_html_file |awk -F":" '{print $1}'`
		rel=`cat $org_list_html_file | tail -n +$line |head -n 4|grep span|grep "$type"|awk -F">" '{print $4}'|awk -F'<' '{print $1}'`
	else
		flg=`echo "$gname"|grep -i $name`
		if [ ! -z $flg ];then
			#echo  fl->$name
			line=`grep -F -n -m 1 ">$gname" $org_list_html_file |awk -F":" '{print $1}'`
			rel=`cat $org_list_html_file | tail -n +$line |head -n 4|grep span|awk -F">" '{print $4}'|awk -F'<' '{print $1}'`
		fi
	fi

	if [ ! -z $rel ];then
		echo -e "\t$rel --> Name:$gname"
	fi
done



IFS=$old_ifs

echo -e "\n\n"

