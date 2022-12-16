#!/bin/bash

#docker run -d --name mosdns -p 5454:53/udp -p 5454:53/tcp -v /etc/mosdns:/etc/mosdns irinesistiana/mosdns:latest
docker run -d --name mosdns\
	--network docker_net\
	--ip 192.168.127.6\
	--dns 192.168.127.1\
	-v /opt/docker/mosdns:/etc/mosdns\ 
	irinesistiana/mosdns:latest

