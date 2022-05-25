#!/bin/bash
src_file_list=
count=0
src_dir=
dst_dir=./
if [ "$2" != "" ] ; then 
	dst_dir=$2 
fi
if [ "$1" = "" ] ; then
	echo -e "\ninput:\n\t$0 srcdir\n"
else
	src_dir=$1
	#echo -e "\n\tcd $src_dir"
	cd $src_dir

	all_file_list=`find ./`
	#echo allfile:$all_file_list
	cd - &>/dev/null 

	for i in $all_file_list; 
	do 
		[ -f $i ] && { count=`expr $count + 1`;
			cp $dst_dir/$i $dst_dir/$i.org;
			cp $src_dir/$i $dst_dir/$i;}
		
		
	
	done
	echo -e "\n\tOK\n"
fi

#for i in $(USELIB); do $(AR) -x $i ; done
