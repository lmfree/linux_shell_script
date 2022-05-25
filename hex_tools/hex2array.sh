#!/bin/bash
help="\n\t$0 in_file out_file\n\t\tplease input parameter 输入文件名 输出的文件名"

if [ $# -lt 2 ];then
	echo -e $help
else
	touch $2
	echo "char app_pack_data[]={" >$2
	hexdump -v -e '16/1 "0x%02X," "\n"' $1 >>$2
	echo "};" >> $2
fi
