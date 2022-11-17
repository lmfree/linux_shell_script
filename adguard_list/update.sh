#!/bin/bash
echo -e "update adguard rule."
idx=1

if [ -f ./url.rd ];then
	ret=`find ./ -name "*.txt"`
	if [ "$ret" != "" ];then
		rm *.txt
	fi

	for url in `cat url.rd`
	do
		echo -e "url$idx:$url"
		wget $url &>/dev/null
		((idx++))
	done
else
	echo -e "not found url.rd file. not update deal."
fi

