#! /bin/bash

USER_SET=""

while getopts u:d:p:f: option
do
case "${option}"
in
u) USER=${OPTARG};USER_SET=true;;
esac
done





sudo apt-get install sshfs

sudo usermod -a -G fuse vid
sudo groupadd fuse

ssh-keygen
ssh-copy-id vid@vidcloud.myqnapcloud.com

sudo sshfs -o credentials=~/ubuntu-start/etc/.sshcredentials IdentityFile=~/.ssh/id_rsa root@:vid@vidcloud.myqnapcloud.com:/share/ /media/vid/NAS

sudo sshfs -o IdentityFile=~/.ssh/id_rsa, credentials=~/ubuntu-start/etc/.sshcredentials vid@vidcloud.myqnapcloud.com:/ /media/vid/NAS 


sshfs#vid@vidcloud.myqnapcloud.com:/share/NAS /media/vid/NAS fuse credentials=~/ubuntu-start/etc/.sshcredentials, ,identityfile=~/.ssh/id_rsa

sshfs#vid@vidcloud.myqnapcloud.com:/share/NAS /media/vid/NAS fuse defaults,allow_other 0 0

USER@HOST:/REMOTE_DIR /LOCAL_DIR fuse.sshfs delay_connect,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/USERNAME/.ssh/id_rsa,allow_other,default_permissions,uid=USER_ID,gid=USER_GID 0 0
,IdentityFile=~/.ssh/id_rsa
