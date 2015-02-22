#! /bin/bash


echo"Backing up bookmarks"
cp /home/vid/.config/gtk-3.0/bookmarks backup/bookmarks

echo "Backing up gsettings"
gsettings list-recursively > backup/gsettings








