#!/bin/bash

for i in $(ls *.patch)
do
	dst_dir=$(basename $i .patch)
	echo "---> patch $i to $dst_dir"
	cd ../$dst_dir
	git apply ../patch/$i
	cd - >/dev/null
done

