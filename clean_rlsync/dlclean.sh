#!/bin/bash
usbdisk_dir=/mnt/sda1

for i in `ls $usbdisk_dir`
do
        if [ -d $usbdisk_dir/$i/.sync/Archive ];then
                echo -e "\n$usbdisk_dir/$i/.sync/Archive:"
                ls -lh $usbdisk_dir/$i/.sync/Archive
		rm $usbdisk_dir/$i/.sync/Archive/* -rf
		du -sh $usbdisk_dir/$i/.sync/Archive
        else
                echo -e "not found \"$usbdisk_dir/$i/.sync/Archive, skip it ...\" "
        fi

done
