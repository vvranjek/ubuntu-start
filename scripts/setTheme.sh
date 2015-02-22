#!/bin/bash



if [ $USER = "root" ]
then
	echo "\n\nDo not use sudo! Please run the script as a current user..\n"
	read -p "Press ENTER to exit..." answer
else

	cur_dir=$(pwd)

	cd /home/$USER/
	mkdir .themes
	mkdir .icons

	echo "Copying themes"

	cp -ar "$cur_dir/../Themes/." "/home/$USER/.themes"
	sudo bash -c "cp -ar $cur_dir/../Themes/. /root/.themes"

	echo "Copying icons"
	cp -ar "$cur_dir/../Icons/." "/home/$USER/.icons" 
	sudo bash -c "cp -ar $cur_dir/../Icons/. /root/.icons"

	echo "Modifying root icons"
	sudo bash -c "mv /root/.icons/Graphite-icons/ /root/.icons/Graphite-icons-original/"
	sudo bash -c "rm -rf /root/.icons/Graphite-icons/"
	sudo bash -c "mv /root/.icons/zoncolorRed/ /root/.icons/Graphite-icons/"

	echo "Setting graphite theme and icons"
	gsettings set org.gnome.desktop.interface gtk-theme "Ambiance-Graphite-dark"
	gsettings set org.gnome.desktop.wm.preferences theme "Ambiance-Graphite-dark"
	gsettings set org.gnome.desktop.interface icon-theme "Graphite-icons"


fi



#read -p "Press ENTER to exit..." answer
