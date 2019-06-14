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


############### Get the directory of original script, not the link
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
echo Script location: $DIR



MNT_NAS=/media/$USER/VIDCLOUD/
sudo mkdir -p $MNT_NAS

sudo umount $MNT_NAS
sudo sshfs -o allow_other vid@vidcloud.myqnapcloud.com:/share/NAS/ $MNT_NAS


