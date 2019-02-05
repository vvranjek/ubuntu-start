#! /bin/bash

USER_SET=""
USER=${SUDO_USER:-${USER}}

while getopts u:d:p:f: option
do
case "${option}"
in
u) USER=${OPTARG};USER_SET=true;;
esac
done

# Info
echo  
echo "Don't forget to forward port $PORT! Press any key..."
read nothing

# Check for user
echo User: $USER
if [[ -z "$USER_SET" ]]; then
    echo "You can set user with [-u user]"
    #exit 1;
fi

# Check if root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root" 
   #exit 1
fi
    

############### Get the directory of original script, not the link
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
echo Script location: $DIR



#MNT_DOWNLAODS=/media/$USER/NAS/Downloads
MNT_NAS=/media/$USER/NAS/
mkdir -p $MNT_NAS




#################### Variables #############################
FSTAB=/etc/fstab
SECRET_FILE="/etc/davfs2/secrets"
PORT="88"
URL=vidcloud.myqnapcloud.com
WEBDEV_URL="http://$URL"
WEBDAV_MOUNT="davfs defaults,_netdev,auto,user  0       0"
CIFS_MOUNT="cifs defaults,rw,credentials=$DIR/.smbcredentials"
SSH_MOUNT="fuse allow_other,noatime,follow_symlinks,delay_connect,defaults,auto,user 0 0"
#CIFS_MOUNT="cifs defaults,rw,credentials=$DIR/.smbcredentials,iocharset=utf8,sec=ntlm 0 0"
#CIFS_MOUNT="cifs defaults,rw,credentials=$DIR/.smbcredentials uid=1000,gid=46,dir_mode=0777,file_mode=0777 0 0"
#CIFS_MOUNT="cifs rw,user,credentials=$DIR/.smbcredentials,uid=1000,gid=1000,iocharset=utf8 0 0


# Fstab comment
# Replace the line if it already exists
if grep -q "QNAP vidcloud configuration" "$FSTAB"; then
    echo "Entry \'QNAP vidcloud configuration\' exists"
else
    echo "Adding \'QNAP vidcloud configuration\' to /etc/fstab"
    sudo printf '\n\n# QNAP vidcloud configuration\n'  >> $FSTAB
fi


############### sshfs #############################
# sshfs#someuser@remote.com:/remote_dir  /media/remote_dir/   fuse    auto,_netdev,port=22,user,allow_other,noatime,follow_symlinks,IdentityFile=/home/someuser/.ssh/id_rsa,reconnect     0       0
# sshfs#USER@MACHINE:/remote/path/ /mnt/local/path/      fuse    user,_netdev,auto_cache,reconnect,uid=1000,gid=1000,IdentityFile=/full/path/to/.ssh/id_rsa,idmap=user,allow_other    0       2

FOLDER="share/"
REMOTE="sshfs#$URL:/$FOLDER"
REMOTE_COMMAND="$REMOTE $MNT_NAS $SSH_MOUNT"

sudo apt-get install sshfs
sudo usermod -a -G fuse $USER
sudo groupadd fuse
mkdir -p $MNT_NAS

echo 

# Generate and copy key if it doesn't exist
if [ ! -f /home/$USER/.ssh/id_rsa ]; then
    	echo "Key not found in /home/$USER/.ssh/"
	ssh-keygen
	ssh-copy-id vid@vidcloud.myqnapcloud.com
fi

# Add "user_allow_other" to /etc/fuse.conf
FUSECONF="/etc/fuse.conf"
if grep -q "user_allow_other" $FUSECONF; then
    echo "Entry user_allow_other exists, replacing"
    sudo sed -i -e "s/.*user_allow_other.*/user_allow_other/" $FUSECONF
else
    echo "Adding user_allow_other to $FUSECONF"
    sudo sh -c "echo "user_allow_other"  >> $FUSECONF"
fi


# Replace the ssh line if it already exists
if grep -q $URL "$FSTAB"; then
    echo "Entry $URL exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$URL" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo sh -c "echo $REMOTE_COMMAND  >> $FSTAB"
fi

# Remove comment for user_allow_other in /etc/fuse.conf
sudo sed '/user_allow_other/s/^# *//' /etc/fuse.conf

mount $MNT_NAS
###################################################

sudo cat $FSTAB

exit 0


################## WebDav ########################

# Add secret for devfs2
echo ""
echo -n "Enter user name of QNAP vidcloud:"
read USERNAME
echo -n "Enter password:"
read -s PASSWORD

chmod 0600 /home/$USER/.dav2fs/secrets 

# Add user to group davfs2
sudo usermod -a -G davfs2 $USER
gpasswd -a $USER davfs2 # this updates users and groups
#newgrp davfs2 # this updates users and groups
#su -l $USER # this updates users and groups
#mkdir -p /home/$USER/.dav2fs/
#touch /home/$USER/.dav2fs/secrets

FOLDER="NAS"
REMOTE=$WEBDEV_URL:$PORT/$FOLDER
REMOTE_COMMAND="$REMOTE $MNT_NAS $WEBDAV_MOUNT"
mkdir -p $MNT_NAS
sudo apt-get install davfs2 -y


# Replace the webdav line if it already exists
if grep -q $URL "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$URL" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo sh -c "echo $REMOTE_COMMAND  >> $FSTAB"
fi

# Replace secret line if it already exists
WEBDEV_SECRET="$WEBDEV_URL:$PORT/$FOLDER $USERNAME  $PASSWORD"
if grep -q "$WEBDEV_URL" "$SECRET_FILE"; then
    echo "Entry vidcloud.myqnapcloud.com exists in secrets, replacing"
    WEBDEV_SECRET=$(echo "$WEBDEV_SECRET" | sed 's/\//\\\//g')
    REPLACE=$(echo "$URL" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REPLACE.*/$WEBDEV_SECRET/" $SECRET_FILE
else
    sudo sh -c "echo "$WEBDEV_URL:$PORT/$FOLDER $USERNAME $PASSWORD" >> $SECRET_FILE"
fi
###################################################




















########################## CIFS ###################################

# Downloads
FOLDER=Download
REMOTE=vidcloud.myqnapcloud.com/$FOLDER
#REMOTE_COMMAND="//$REMOTE /home/$USER/NAS/Downloads $CIFS_MOUNT"
REMOTE_COMMAND="http://$REMOTE /home/$USER/NAS/Downloads $WEBDAV_MOUNT"
mkdir -p /home/$USER/NAS/Downloads
sudo apt-get install cifs-utils -y 

# Replace the line if it already exists
if grep -q $REMOTE "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$REMOTE" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo sh -c "echo $REMOTE_COMMAND  >> $FSTAB"
fi

# vidcloud
FOLDER=vidcloud
REMOTE=vidcloud.myqnapcloud.com/$FOLDER
REMOTE_COMMAND="//$REMOTE /home/$USER/NAS/$FOLDER $CIFS_MOUNT"
mkdir -p /home/$USER/NAS/$FOLDER

# Replace the line if it already exists
if grep -q $REMOTE "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$REMOTE" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo sh -c "echo $REMOTE_COMMAND  >> $FSTAB"
fi

# Multimedia
FOLDER=Multimedia
REMOTE=vidcloud.myqnapcloud.com/$FOLDER
REMOTE_COMMAND="//$REMOTE /home/$USER/NAS/$FOLDER $CIFS_MOUNT"
mkdir -p /home/$USER/NAS/$FOLDER

# Replace the line if it already exists
if grep -q $REMOTE "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$REMOTE" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo sh -c "echo $REMOTE_COMMAND  >> $FSTAB"
fi

echo Restart the com

