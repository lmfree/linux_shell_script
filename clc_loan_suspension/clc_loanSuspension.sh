#!/bin/bash

echo ""

get_file="wget https://github.com/WeNeedHome/SummaryOfLoanSuspension/blob/main/README.md"

[ "$1" = "update" ] && rm README.md* -f && $get_file
[ -f README.md ] ||  $get_file

start_lnum=`cat README.md |grep user-content-其他数据公示处 -n|awk -F':' '{print $1}'`
((start_lnum=start_lnum+1))

end_lnum=`cat README.md |wc -l`
#echo -e "$start_lnum,$end_lnum"

counts=0;
#grep content-|sed -e "s/--/-/g"|awk -F'-' '{print $4}'|awk -F'"' '{print $1}'
sed -n "$start_lnum,${end_lnum}p" README.md |grep content-| while read line; 
do 
	#cnt=$(echo $line|sed -e "s/--/-/g" |awk -F'-' '{print $2}'|awk -F'-' '{print $1}'); 
	cnt=$(echo $line|sed -e "s/--/-/g" |awk -F'-' '{print $4}'|awk -F'"' '{print $1}')
	((index+=1))
	#echo -n "$index:counts($counts) + cnt($cnt) = "
	((counts=counts+cnt)); 
	echo $counts > .tmp
done;

echo -e "clc result:"
echo -e "1. all loan suspension --> `cat .tmp`"

for i in `cat README.md |grep "<li><strong>"|awk -F'（' '{print $2}'|awk -F'）' '{print $1}'`; 
do 
	#$echo -n "cnts($cnts)+$i="; 
	((cnts+=i)); 
	echo $cnts > .tmp 
done

echo -e "2. all loan suspension --> `cat .tmp` \n"

rm .tmp -f

cat README.md |grep 大连 |sed -e 's/<li><strong>//g' |sed -e 's/<\/li>/ /g' |sed -e 's/<\/strong>//g'

org_counts=`cat README.md |grep " href=\"#总数"|grep true|awk -F'#' '{print $2}' |awk -F"\"" '{print $1}'`
echo -e "\ndoc org counts: $org_counts"
echo ""

