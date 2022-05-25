#!/bin/bash
#ls |awk -F"." '{for(i=1;i<=NF;i++){if(substr($i,3,1)>"\177"){cmd="mkdir "$i";""mv "$0" "$i"."$NF; print cmd;break}}}'

if [ $# -gt 0 ]; then
	ls |awk -F"." '{for(i=1;i<=NF;i++){if(substr($i,3,1)>"\177"){cmd="mkdir "$i";""mv "$0" "$i; print cmd;system(cmd);break}}}'
else
	ls |awk -F"." '{for(i=1;i<=NF;i++){if(substr($i,3,1)>"\177"){cmd="mkdir "$i";""mv "$0" "$i; print cmd;break}}}'
fi
