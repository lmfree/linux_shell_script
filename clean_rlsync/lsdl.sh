#!/bin/bash
usbdisk_dir=/mnt/sda1

for i in `ls $usbdisk_dir`
do
	if [ -d $usbdisk_dir/$i/.sync/Archive ];then
		echo -e "\n$usbdisk_dir/$i/.sync/Archive:"
		ls -lh $usbdisk_dir/$i/.sync/Archive
		echo -e "\nTotal File Size:"
		du -sh $usbdisk_dir/$i/.sync/Archive
		echo -e $N_COL
	else
		echo -e "not found \"$usbdisk_dir/$i/.sync/Archive, skip it ...\" "
	fi

done

