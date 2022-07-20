#/bin/bash

ftp_root=/home/ftp_root

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo "please input username and password"
else
	username=$1
	password=$2
	error=0
	if [ "$3" != "" ] ;then
		grp=$3
	else
		grp=root
	fi

	ret_str=`sudo cat /etc/passwd | grep $username`
	if [ -z $ret_str ];then
		#add system user.
		./adduser.sh $username $password $grp
	else
		echo -e "found user[$username] not add to /etc/passwd"
	fi

	#vsftp config.
	echo -e "add vsftp user root dir --> $ftp_root/$username"
	sudo mkdir -p $ftp_root/$username
	sudo chown $username $ftp_root/$username -R
	sudo chgrp $grp $ftp_root/$username -R

	[ -d /etc/vsftpd/userconfig ] || sudo mkdir -p /etc/vsftpd/userconfig
	echo -e "local_root=$ftp_root/$username\n" | sudo tee /etc/vsftpd/userconfig/$username >/dev/null
	echo -e "$username" | sudo tee -a /etc/allowed_users >/dev/null

	echo 'done!'
fi


