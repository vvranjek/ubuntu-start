#! /bin/bash

CUR_DIR=$(pwd)

if [ $# != 0 ]; then
	DIR=$0
else
	DIR=$CUR_DIR
fi
	

echo "Backing up bookmarks to $DIR/bookmarks_backup"
cp /home/$USER/.config/gtk-3.0/bookmarks $1/bookmarks_backup

echo "Backing up gsettings to $DIR/gsettings_backup"
gsettings list-recursively > $1/gsettings_backup