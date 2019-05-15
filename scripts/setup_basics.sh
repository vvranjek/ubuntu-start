#! /bin/bash


SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`
#SCRIPTS_DIR=$(find `pwd` -name "scripts")
NAUTILUS_SCRIPTS_DIR=$SCRIPTS_DIR/../nautilus-scripts
FILENAME=$SCRIPTS_DIR/package-list

echo "SCRIPT = $SCRIPT"
echo "SCRIPTS_DIR = $SCRIPTS_DIR"
echo "NAUTILUS_SCRIPTS_DIR = $NAUTILUS_SCRIPTS_DIR"
echo "FILENAME = $FILENAME"
sleep 3

sudo chmod +x $SCRIPTS_DIR/*

echo
echo "Creating 'Programs' and 'bin' folders."
mkdir -p /home/$USER/Programs
mkdir -p /home/$USER/bin
sleep 0.3

echo
echo "Creating links for Nautilus scripts"
ln -s $NAUTILUS_SCRIPTS_DIR/* /home/$USER/.local/share/nautilus/scripts/

echo
echo "Creating links of scripts in bin."
ln -s $SCRIPTS_DIR/* /home/$USER/bin/
#cp -r $SCRIPTS_DIR/ /home/$USER/bin
sleep 0.3

echo
echo "Adding $USER to group dialout and sudo"
sudo adduser $USER dialout
sudo adduser $USER sudo
sudo adduser $USER vid
sleep 0.3

exit 0




