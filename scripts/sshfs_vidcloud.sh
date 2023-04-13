#! /bin/bash

#ssh vid@vidcloud.myqnapcloud.com
#ssh-keygen
#ssh-copy-id -i ~/.ssh/id_rsa.pub vid@vidcloud.myqnapcloud.com

MOUNT_SOURCE="/"
MOUNT_TARGET=/media/$USER/NAS
SERVER="192.168.111.200"


sudo mkdir -p $MOUNT_TARGET

sudo sshfs -o reconnect,allow_other,IdentityFile=/home/vid/.ssh/id_rsa vid@$SERVER:$MOUNT_SOURCE $MOUNT_TARGET

#sudo sshfs -o allow_other vid@vidcloud.myqnapcloud.com:/share/CACHEDEV1_DATA/NAS/ /media/vid/NASsh

