#!/bin/bash

#/var/etc/passwall/bin/haproxy -f /var/etc/passwall/haproxy/config.cfg -sf `ps |grep haproxy|grep -v grep|awk '{print $1}'`

date "+%Y-%m-%d %H:%M:%S"
echo "reset passwall..."
/etc/init.d/passwall restart
