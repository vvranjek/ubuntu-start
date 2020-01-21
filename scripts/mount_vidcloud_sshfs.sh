#! /bin/bash

USER_SET=""
ROOT_SET=""
USER=${SUDO_USER:-${USER}}

while getopts ur option
do
    case "${option}"
    in
    u)
        echo "User set"
        USER_SET=true;;
    r) 
        echo "Root set"
        ROOT_SET=true;;
esac
done

if [ "$USER_SET" != "true" ] && [ "$ROOT_SET" != "true" ]; then
    echo
    echo "Plese use option -u (user) or -r (root)"
    exit 1
fi

# Info
echo  
echo "Don't forget to forward port $PORT! Press any key..."
#read nothing




############### Get the directory of original script, not the link
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
echo Script location: $DIR



# Mount NAS user

if [ "$USER_SET" == "true" ]; then
    echo
    echo "Mounting VIDCLOUD"
    MNT_NAS=/media/$USER/VIDCLOUD/
    sudo mkdir -p $MNT_NAS
    sudo umount $MNT_NAS
    sudo sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,allow_other vid@vidcloud.myqnapcloud.com:/share/NAS/ $MNT_NAS
fi



# Mount root
if [ "$ROOT_SET" == "true" ]; then
    echo
    echo "Mounting VIDCLOUD_ROOT"
    MNT_NAS_ROOT=/media/$USER/VIDCLOUD_ROOT/
    sudo mkdir -p $MNT_NAS_ROOT
    sudo umount $MNT_NAS_ROOT
    sudo sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,allow_other vid@vidcloud.myqnapcloud.com:/ $MNT_NAS_ROOT
fi


