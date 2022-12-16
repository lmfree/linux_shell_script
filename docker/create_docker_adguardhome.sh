#!/bin/bash
: '
docker run --name adguardhome1\
    --restart unless-stopped\
    -v /share/app-set/docker/adguardhome/work:/opt/adguardhome/work\
    -v /share/app-set/docker/adguardhome/conf:/opt/adguardhome/conf\
    -p 68:68/udp\
    -p 3000:3000/tcp\
    -p 853:853/tcp\
    -p 784:784/udp -p 853:853/udp -p 8853:8853/udp\
    -p 5443:5443/tcp -p 5443:5443/udp\
    -d adguard/adguardhome


docker run -d

--name=xxxx

--network macvlan

--ip=192.168.0.39

--dns=192.168.0.29

--restart=always

--name=movie-robot
'
docker run --name adguardhome_macvlan\
    --network docker_net\
    --ip=192.168.30.2\
    --dns=8.8.8.8\
    --restart=always\
    -m 2048m\
    -v /share/app-set/docker/adguardhome/work:/opt/adguardhome/work\
    -v /share/app-set/docker/adguardhome/conf:/opt/adguardhome/conf\
    -p 53:53/tcp -p 53:53/udp\
    -p 67:67/udp -p 68:68/udp\
    -p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp\
    -p 853:853/tcp\
    -p 784:784/udp -p 853:853/udp -p 8853:8853/udp\
    -p 5443:5443/tcp -p 5443:5443/udp\
    -d adguard/adguardhome

