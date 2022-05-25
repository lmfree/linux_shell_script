#!/bin/bash

if [ $# -gt 1 ];then
	dst_dir=$1
	verify_size=$2
else
	echo -e "$0 dst_dir verify_size"
	exit 0
fi

function float_calc()
{
	in=$1
	if [ "$in" = "" ];then
		return 1
	fi
	#echo $1
	val=$(awk "BEGIN{print $in }")
	echo ${val#-}
	return 0
}

#convert size to byte
function cvt2byte()
{
	in=$1
	if [ "$in" = "" ];then
		return 1
	fi
	flag_k=0
	echo $in |grep -i 'k' >/dev/null
	flag_k=$?
	
	flag_m=0
	echo $in |grep -i 'm' >/dev/null
	flag_m=$?
	
	flag_g=0
	echo $in |grep -i 'g' >/dev/null
	flag_g=$?

	#debug
	#echo -e "$flag_k, $flag_m, $flag_g"
	
	val=0
	if [ $flag_k -eq 0 ];then
		val=`echo $in|sed -e 's/k//i'`
		#echo $(echo "$val * 1024"|bc|awk -F. '{print $1}')
		echo `float_calc "$val*1024"|awk '{printf("%d",$1)}'`
		return 0
	fi

	if [ $flag_m -eq 0 ];then
		val=`echo $in|sed -e 's/m//i'`
		#echo -e "$val m"
		#val=$(echo "$val * 1024 * 1024"|bc|awk -F. '{print $1}')
		val=`float_calc "$val*1024*1024"|awk '{printf("%d",$1)}'`
		#echo -e "$val bytes"
		echo $val
		return 0
	fi

	if [ $flag_g -eq 0 ];then
		val=`echo $in|sed -e 's/g//i'`
		#echo -e "$val g"
		#echo $(echo "$val * 1024 * 1024 * 1024"|bc|awk -F. '{print $1}')
		val=`float_calc "$val*1024*1024*1024"|awk '{printf("%d",$1)}'`
		echo ${val#-}
		return 0
	fi

	return 1
}

verify_size=`cvt2byte $verify_size`
echo -e "verify size: $verify_size"

#calc dir 
function calc_dirsize()
{
	dir_name=$1
	if [ "$dir_name" = "" ];then
		echo -e "not input dirname, exit ..."
		return 1
	fi
	if [ ! -d $dir_name ];then
		echo -e "not found di--> $dir_name"
		return 1
	fi
	
	size=`du -sh $dir_name|awk '{print $1}'`
	echo `cvt2byte $size`
	return 0
}

echo -e "check dir $dst_dir"
for i in `ls -l  --time-style=full-iso $dst_dir|grep ^d|awk '{print $9}'`
do
	#echo -----$i
	#size_byte=`calc_dirsize $dst_dir/$i|awk -F. '{print $1}'`
	size_byte=`calc_dirsize $dst_dir/$i`
	#echo "$size_byte vs $verify_size"
	if [ $size_byte -lt $verify_size ];then
		echo -e "----- $dst_dir/$i size is $size_byte"
	fi
done



