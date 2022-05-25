#!/bin/bash

cur_dir=`pwd`

if [ $# != 2 ]; then
	echo -e "input: \n\t$0 openwrt_file armbian.img_file\n"
else
	openwrt_file=$1
	armbian_file=armbian.img
	
	op_type=0
	tar_t="tar.gz"
	img_t="img.gz"
	
	if [[ $openwrt_file =~ $tar_t ]]; then
		op_type=1
	elif [[ $openwrt_file =~ $img_t ]]; then
		op_type=2
	else
		echo -e "not suport file type: $openwrt_file"
		exit 1
	fi
	
	echo -e "op_type=$op_type"

	cp $2 $armbian_file -av
	
	arm_dir=armbian
	rt_dir=openwrt
	echo -e "prepare dir: $rt_dir, $arm_dir"
	test -d ./$arm_dir && sudo rm ./$arm_dir -rf; 
	mkdir -p ./$arm_dir
	test -d ./$rt_dir  && sudo rm ./$rt_dir  -rf; 
	mkdir -p ./$rt_dir
	
	echo -e "prepare openwrt data from $openwrt_file"
	if [ $op_type == 2 ]; then
		echo -e "mount and copy openwrt img file."
		
		mkdir -p tmp_mnt
		cp -a $openwrt_file openwrt_tmp.img.gz
		gunzip  openwrt_tmp.img.gz
		img_op=`ls *.img|grep openwrt_tmp`
		echo -e "get openwrt img file: $img_op"
		
		sudo losetup -P -f --show $img_op >tmp
		loop_nod=`cat tmp|grep loop`
		if [ "$loop_nod" == "" ]; then
			echo "losetup error"
		else
			echo "losetup result:$loop_nod"
			loop_dev=$loop_nod"p2"
			sudo mount $loop_dev tmp_mnt
			[ $? != 0 ] && exit 1
			echo -e "copy all tmp_mnt/ to $rt_dir"
			sudo cp tmp_mnt/* $rt_dir/ -a
			
			echo -e "umount tmp_mnt/ and release loop node: $loop_nod"
			sudo umount tmp_mnt
			sudo losetup -d $loop_nod
			sudo rm -fr $img_op tmp_mnt/
			loop_nod=""
			loop_dev=""
		fi
	else
		echo -e "extract openwrt tar.gz file"
		tar xf $openwrt_file -C ./$rt_dir
	fi
	
	echo -e "create loop dev and mount it to $arm_dir"
	sudo losetup -P -f --show $armbian_file >tmp
	loop_nod=`cat tmp`
	
	if [ "$loop_nod" == "" ]; then
		echo "losetup error"
	else
		echo "losetup result:$loop_nod"
		loop_dev=$loop_nod"p2"
		sudo mount $loop_dev ./$arm_dir
		[ $? != 0 ] && exit 1
		
		echo -e "move $arm_dir data to $rt_dir..."
		sudo rm -rf ./$rt_dir/lib/firmware
		sudo rm -rf ./$rt_dir/lib/modules
		sudo mv ./$arm_dir/lib/modules    ./$rt_dir/lib/
		sudo mv ./$arm_dir/lib/firmware   ./$rt_dir/lib/
		sudo mv ./$arm_dir/etc/modprobe.d ./$rt_dir/etc/
		sudo mv ./$arm_dir/etc/fstab      ./$rt_dir/etc/
		cd $cur_dir

		echo -e "cp link.sh file, and use it."
		cd ./$rt_dir/lib/modules/4.18.7-aml-s9xxx
		#cat $cur_dir/link.sh
		sudo cp $cur_dir/link.sh ./link-ko.sh; sudo chmod +x link-ko.sh
		sudo ./link-ko.sh
		ls -l >$cur_dir/link.log
		
		echo -e "deal boot and wifi_enable file..."
		cd $cur_dir
		sudo cp boot $rt_dir/etc/init.d/boot -a
		sudo cp -vf wireless_enable $rt_dir/etc/modules.d/wireless_enable
		sudo chmod 777 $rt_dir/etc/modules.d/wireless_enable
		
		echo -e "clear dir: $arm_dir"
		cd $cur_dir
		sudo rm -rf ./$arm_dir/*
		
		echo -e "move data from $rt_dir to $arm_dir"
		sudo mv $rt_dir/* $arm_dir/
		sudo mkdir -p $arm_dir/boot
		
		echo -e "sync data to img file"
		sync
		
		echo -e "umount $arm_dir and node $loop_nod."
		cd $cur_dir/
		sudo umount $arm_dir
		sudo losetup -d $loop_nod
		
		echo -e "delete all tmp file."
		sudo rm $arm_dir $rt_dir tmp -rf
	fi
fi
