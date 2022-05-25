#!/bin/bash
username=$1
password=$2
error=0

if [ "$username" != "" ] ; then
	if [ "$password" != "" ] ; then
		echo -e "$password\n$password"|sudo smbpasswd -a $username
	else
		error=1
	fi
else
	error=1
fi

if [ "$error" = "1"  ] ; then
	echo -e "\t$0 username password"
else
	echo -e "\n\tadd samba user:  $username OK."
fi

