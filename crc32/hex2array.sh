#!/bin/bash
help="\n\t$0 in_file out_file\n\t\tplease input parameter 输入文件名 输出的文件名"

crc32_checksum_file=./tmp_crc32

if [ $# -lt 2 ];then
	echo -e $help
else
	#get input file size
	in_file=$1
	size=`stat -c '%s' $in_file`
	echo size=$size
	#convert to hex data
	size=`printf '%08x\n' $size`
	echo size=$size

	#get crc32 data to tmp file.
	touch $crc32_checksum_file
	[ -f ./crc ] && ./crc $in_file $crc32_checksum_file
	size_crc_logodata=${in_file}_size_crc.bin

	#output size + crc32 + logo data to one new file.
	touch $size_crc_logodata
	#echo 001122334455 | xxd -r -ps > test
	echo $size | xxd -r -ps   >$size_crc_logodata
	cat $crc32_checksum_file >>$size_crc_logodata
	cat $in_file             >>$size_crc_logodata

	#del tmp file.
	rm -f $crc32_checksum_file

	#output array .h file
	touch $2
	echo "char bootlogo_data[]={" >$2
	hexdump -v -e '16/1 "0x%02X," "\n"' $size_crc_logodata >>$2
	echo "};" >> $2

	#del invalid data -> "0x  ," 
	sed -i 's/0x  ,//g' $2
fi
