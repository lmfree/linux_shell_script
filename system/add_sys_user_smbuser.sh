#/bin/bash
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

	#add system user.
	./adduser.sh $username $password $grp

	#add samba user.
	./smbadduser.sh $username $password

	#modify smb cfg file.
	./cfg_samba.sh $username

	echo 'done!'
fi


