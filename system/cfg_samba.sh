#!/bin/bash
username=$1
userfile=$2

add_user_to_smb()
{
	user_name=$1
	sudo chmod 777 /etc/samba/smb.conf
	sudo cat >>/etc/samba/smb.conf <<EOF

[$user_name]
	path=/home/$user_name
	available=yes
	browseable=yes
	public=no
	valid user = $user_name
	writable=yes
EOF
}

if [ "$userfile" != "" ] ; then
	username_from_file=`cat $userfile |awk '{print $1}'`
	echo $username_from_file
	for i in $username_from_file 
	do
		add_user_to_smb $i
		echo -e "\t add $i to /etc/samba/smb.conf, ok"
	done

else
if [ "$username" != "" ] ; then
	add_user_to_smb $username
	echo -e "\t add $username to /etc/samba/smb.conf, ok"
else
	echo -e "\t $0 username [user_info_file]"
fi

fi

