#!/bin/bash
docker network create -d macvlan \
  --subnet=192.168.30.0/24 \
  --gateway=192.168.30.1 \
  -o parent=br-lan docker_net
