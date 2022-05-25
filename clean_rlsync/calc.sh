#!/bin/bash

rel=`lsdl |grep -v ^/|grep -v ^not|grep -v -i Total`

if [ "$rel" = "" ];then
	echo -e "not need calc size .."
fi

#calc size K ...
rel_k=`echo $rel|grep K`
size_k=0
if [ "$rel_k" != "" ];then
	for i in `lsdl |grep -v ^/|grep -v ^not|grep -v -i Total|awk -F'K' '{print $1}'`
	do
		sz=`echo $i|awk -F'.' '{print $1}'`
		size_k=$(( $sz + $size_k ))
	done
	echo -e "size k: $size_k"
fi

#calc size M ...        
rel_m=`echo $rel|grep M`
size_m=0                  
if [ "$rel_m" != "" ];then                                                              
        for i in `lsdl |grep -v ^/|grep -v ^not|grep -v -i Total|awk -F'M' '{print $1}'`
        do                                         
                sz=`echo $i|awk -F'.' '{print $1}'`
                size_m=$(( $sz + $size_m ))
        done                     
        echo -e "size m: $size_m"
fi

#calc size G ...        
rel_g=`echo $rel|grep G`
size_g=0                  
if [ "$rel_g" != "" ];then                                                              
        for i in `lsdl |grep -v ^/|grep -v ^not|grep -v -i Total|awk -F'G' '{print $1}'`
        do                                         
                sz=`echo $i|awk -F'.' '{print $1}'`
                size_g=$(( $sz + $size_g ))
        done                     
        echo -e "size g: $size_g"
fi

#`lsdl |grep -v ^/|grep -v ^not|grep -v Total|awk -F'K' '{print $1}'`
