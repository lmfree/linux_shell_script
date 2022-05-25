#!/bin/bash

org_src=boot0.jpg
bk_file=boot0_org.jpg
new_file=boot0.sig_fak

if [ -f ./$org_src ];then
cp $org_src $bk_file -a
touch $new_file
echo 00112233 | xxd -r -ps >$new_file
cat $org_src >>$new_file
ls -l $new_file
fi
