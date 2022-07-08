#!/bin/bash
if [ "$1" = "getname" ];then
        url=$2
else
        url=$1
fi

fn=$(echo $url | sed 's/&/\n/g')
echo -e "\n1.convert to --> $fn\n"

fn=$(echo "$fn" | grep 'fin=')
echo -e "\n2.convert to --> $fn\n"

fn=$(echo $fn | sed "s/fin=//g")
echo -e "\n3.convert to --> $fn\n"

fn=$(echo "$fn" | sed "s/&//g")
echo -e "\n4.convert to --> $fn\n"

#fn=$(printf $(echo -n "$fn" | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n")
fn=$(printf $(echo -n "$fn" | sed 's/\\/\\\\/g')"\n")
echo -e "\n5.convert to --> $fn\n"
