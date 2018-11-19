#! /bin/bash


SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`

CUR_DIR=$SCRIPTS_DIR

if [ $# != 0 ]; then
	DIR=$0
else
	DIR=$CUR_DIR
fi

echo "Backing up gsettings to $DIR/gsettings_backup"
gsettings list-recursively > $DIR/gsettings_backup

exit 0	

echo "Backing up bookmarks to $DIR/bookmarks_backup"
cp /home/$USER/.config/gtk-3.0/bookmarks $1/bookmarks_backup


