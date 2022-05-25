#/bin/bash
username=$1
password=$2
error=0
if [ "$3" != "" ] ;then
	grp=$3
else
	grp=root
fi

if [ "$username" != "" ] ; then
	if [ "$password" != "" ] ; then
		echo -e '\tadd system user.'
		sudo useradd -m $username -g $grp
		echo $username:$password |sudo chpasswd
		
		echo -e '\tadd samba user.'
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
	echo -e "\n\tadd user:  $username OK."
	sudo cp /home/liming/.bashrc /home/$username/ -a
fi

