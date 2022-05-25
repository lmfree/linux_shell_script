#!/bin/bash

docker run -d --name jellyfin --restart=always --device /dev/dri/renderD128:/dev/dri/renderD128 --device /dev/dri/card0:/dev/dri/card0 -v /share/Docker/JellyfinData/AppData/config:/config -v /share/Docker/JellyfinData/AppData/cache:/cache -v /share/CACHEDEV3_DATA/影视:/media -p 8096:8096 jellyfin/jellyfin


