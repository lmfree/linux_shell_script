#!/bin/bash

if [ $# -lt 1 ];then
	echo -e "input decrypt file name."
	exit 1
fi

if [ -z $2 ];then

if [ "`echo $1|grep '.gpg'`" != "" ];then
	echo -e "find .gpg file."
	outf=`echo $1 |awk -F'.gpg' '{print $1}'`
elif [ "`echo $1|grep '.pgp'`" != "" ];then
	echo -e "find .pgp file."
	outf=`echo $1 |awk -F'.pgp' '{print $1}'`
else
	echo -e "is not .gpg or .pgp file.not decrypt and exit."
	exit 1
fi

else
	outf=$2
fi

[ -f $outf ] && rm -vf $outf

gpg --passphrase "${dlr780101}" -o $outf -d $1

echo -e $BLUE_L_COLOR"\ndecrypt out file --> $outf\n"$NORMAL_COL

