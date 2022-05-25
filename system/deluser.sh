#!/bin/bash
username=$1
error=0
if [ "$username" != "" ] ; then
		sudo userdel -r $username
		#sudo rm -rf /home/$username
	else
		error=1
	fi

if [ "$error" = "1"  ] ; then
	echo -e "\t$0 username "
else
	echo -e "\n\tdelete user: $username OK."
fi

