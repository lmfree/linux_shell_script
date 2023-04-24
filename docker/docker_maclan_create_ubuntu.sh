#!/bin/bash
docker network create -d macvlan \
  --subnet=192.168.127.0/24 \
  --gateway=192.168.127.1 \
  -o parent=enp0s31f6 docker_net
  
