#!/bin/bash
resolvconf &>/dev/null
[ $? -eq 127 ] && sudo apt install -y resolvconf

sudo resolvconf -u

