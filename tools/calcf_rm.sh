#!/bin/bash

file=$1
size=$2

# 检查文件是否存在
if [ ! -f "$file" ]; then
  #echo "Error: 文件不存在"
  touch $file
  exit 0
fi

# 检查文件大小是否大于给定值
filesize=$(stat -c%s "$file")
if [ $filesize -gt $size ]; then
  #echo "文件大小超出限制，需要删除并新建文件"
  rm "$file"
  touch "$file"
fi

