#!/bin/bash

if [ "$1" = "" ];then
	svn add . --no-ignore --force
else
	svn add $1 --no-ignore --force
fi

