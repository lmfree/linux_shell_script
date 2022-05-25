#!/bin/bash

if [ $# -lt 1 ];then
        echo -e "input encrypt sign src file name."
		exit 1
fi

input=$1

if [ -z $2 ];then
outf="${input}.gpg"
else
outf=$2
fi

[ -f $outf ] && rm -fv $outf
gpg -se -r liming@ovtec.com -r NASC_signing@nagra.com --passphrase "${dlr780101}" -o $outf $input

echo -e $YELLOW_COL"output file --> $outf"$NORMAL_COL

