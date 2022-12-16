#!/bin/bash
docker run --name adguardhome_macvlan\
    --network docker_net\
    --ip=192.168.127.5\
    --restart=always\
    -v /opt/docker/adguardhome/work:/opt/adguardhome/work\
    -v /opt/docker/adguardhome/conf:/opt/adguardhome/conf\
    -d adguard/adguardhome
