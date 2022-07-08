#!/usr/bin/python3
#encoding:utf-8
import base64
import sys

list_p=sys.argv
#print(len(list_p))
#print(list_p)
#print(list_p[0])

if len(list_p) == 1:
	exit(0)

#for i in range(1,len(list_p)):
#	print(i)
#	pass

info_org=open(list_p[1]).read()

#str_encrypt=input("输入要加密的字符串:\n"); 
base64_encrypt = base64.b64encode(info_org.encode('utf-8'))
print(str(base64_encrypt,'utf-8'))


