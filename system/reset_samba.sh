#!/bin/bash
#sudo /etc/init.d/samba restart
sudo service nmbd stop
sudo service smbd stop
sudo /etc/init.d/samba status
sudo service nmbd start
sudo service smbd start
sudo /etc/init.d/samba status


