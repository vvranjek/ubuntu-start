
#! /bin/bash

#ssh vid@vidcloud.myqnapcloud.com
#ssh-keygen
#ssh-copy-id -i ~/.ssh/id_rsa.pub vid@vidcloud.myqnapcloud.com

MOUNT_POINT=/media/$USER/NAS2

mkdir -p $MOUNT_POINT

sudo sshfs -o reconnect,allow_other,IdentityFile=/home/vid/.ssh/id_rsa vid@vidcloud.myqnapcloud.com:/share/CACHEDEV1_DATA/NAS/ $MOUNT_POINT

#sudo sshfs -o allow_other vid@vidcloud.myqnapcloud.com:/share/CACHEDEV1_DATA/NAS/ /media/vid/NASsh

