
#! /bin/bash

ssh vid@vidcloud.myqnapcloud.com
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub vid@vidcloud.myqnapcloud.com

sudo sshfs -o allow_other vid@vidcloud.myqnapcloud.com:/share/CACHEDEV1_DATA/NAS/ /media/vid/NASsh
