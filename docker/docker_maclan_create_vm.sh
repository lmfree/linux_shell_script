#!/bin/bash
docker network create -d macvlan \
  --subnet=192.168.127.0/24 \
  --gateway=192.168.127.1 \
  -o parent=eth0 docker_net
  