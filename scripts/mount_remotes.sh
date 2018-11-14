#! /bin/bash

USER_SET=""

while getopts u:d:p:f: option
do
case "${option}"
in
u) USER=${OPTARG};USER_SET=true;;
esac
done

# Info
echo  
echo "Don't forget to forward port 80! Press any key..."
read nothing

# Check for user
if [[ -z "$USER_SET" ]]; then
    echo "Please set user with [-u user]"
    exit 1;
fi

# Check if root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root" 
   exit 1
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


############### Install dependencies
sudo apt-get install cifs-utils -y 
sudo apt-get install davfs2 -y


#MNT_DOWNLAODS=/media/$USER/NAS/Downloads
MNT_NAS=/media/$USER/NAS/
mkdir -p $MNT_NAS

############### Add secret for devfs2
echo "Enter user name of QNAP vidcloud:"
read USERNAME
echo "Enter password:"
read PASSWORD

chmod 0600 /home/$USER/.dav2fs/secrets 

# Add user to group davfs2
sudo usermod -a -G davfs2 $USER
gpasswd -a $USER davfs2 # this updates users and groups
#newgrp davfs2 # this updates users and groups
#su -l $USER # this updates users and groups
#mkdir -p /home/$USER/.dav2fs/
#touch /home/$USER/.dav2fs/secrets


#################### Variables
FSTAB=/etc/fstab
SECRET_FILE="/etc/davfs2/secrets"
WEBDEV_URL="http://vidcloud.myqnapcloud.com"
WEBDAV_MOUNT="davfs defaults,_netdev,auto,user  0       0"
CIFS_MOUNT="cifs defaults,rw,credentials=$DIR/.smbcredentials"
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



####################### NAS ###################################
FOLDER=NAS
REMOTE=vidcloud.myqnapcloud.com/$FOLDER
REMOTE_COMMAND="http://$REMOTE $MNT_NAS $WEBDAV_MOUNT"
mkdir -p $MNT_NAS

# Replace the line if it already exists
if grep -q $REMOTE "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$REMOTE" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo echo $REMOTE_COMMAND  >> $FSTAB
fi

# Replace secret line if it already exists
WEBDEV_SECRET="$WEBDEV_URL/$FOLDER $USERNAME  $PASSWORD"
if grep -q "$WEBDEV_URL" "$SECRET_FILE"; then
    echo "Entry vidcloud.myqnapcloud.com exists in secrets, replacing"
    WEBDEV_SECRET=$(echo "$WEBDEV_SECRET" | sed 's/\//\\\//g')
    REPLACE=$(echo "vidcloud.myqnapcloud" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REPLACE.*/$WEBDEV_SECRET/" $SECRET_FILE
else
    sudo echo "$WEBDEV_URL/$FOLDER $USERNAME $PASSWORD" >> $SECRET_FILE
fi





exit 0




















# Downloads
FOLDER=Download
REMOTE=vidcloud.myqnapcloud.com/$FOLDER
#REMOTE_COMMAND="//$REMOTE /home/$USER/NAS/Downloads $CIFS_MOUNT"
REMOTE_COMMAND="http://$REMOTE /home/$USER/NAS/Downloads $WEBDAV_MOUNT"
mkdir -p /home/$USER/NAS/Downloads

# Replace the line if it already exists
if grep -q $REMOTE "$FSTAB"; then
    echo "Entry $REMOTE exists, replacing"
    REMOTE_DOWNLOADS_COMMAND_SED=$(echo "$REMOTE_COMMAND" | sed 's/\//\\\//g')
    REMOTE_DOWNLOADS_SED=$(echo "$REMOTE" | sed 's/\//\\\//g')
    sudo sed -i -e "s/.*$REMOTE_DOWNLOADS_SED.*/$REMOTE_DOWNLOADS_COMMAND_SED/" $FSTAB
else
    sudo echo $REMOTE_COMMAND  >> $FSTAB
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
    sudo echo $REMOTE_COMMAND  >> $FSTAB
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
    sudo echo $REMOTE_COMMAND  >> $FSTAB
fi

echo Restart the com

