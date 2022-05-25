#!/bin/bash
wget --no-check-certificate https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz -O resilio-sync_x64.tar.gz

#echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
#curl -LO http://linux-packages.resilio.com/resilio-sync/key.asc && sudo apt-key add ./key.asc
#sudo apt-get update
#sudo apt-get install resilio-sync
