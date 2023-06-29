#!/bin/bash
[ -d ./patch ] || mkdir -p ./patch

for i in $(find ./ -maxdepth 2 -name .git) 
do 
	dst_dir=$(echo $i|sed -e 's/\.git//g'|sed -e 's/^\.\///g'|sed -e 's/\/$//g')
	echo "--> $dst_dir"
	cd $dst_dir
	git diff . >../patch/$dst_dir.patch
	cd - &>/dev/null
done

