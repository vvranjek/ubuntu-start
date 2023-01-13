#!/bin/bash

# UBUNtU-TWEAK note: this is a natty repo!
#  sudo add-apt-repository 'deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu natty main'

clear
echo "Hello and welcome to this must have Ubuntu installation script."
echo
sleep 0.5

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`
NAUTILUS_SCRIPTS_DIR=$SCRIPTS_DIR/../nautilus-scripts
FILENAME=$SCRIPTS_DIR/package-list

# Setup basic stuff
$SCRIPTS_DIR/setup_basics.sh

# install Slovenian for libreoffice
$SCRIPTS_DIR/install_libreoffice_slo_pack.sh

# Install and setup zsh
$SCRIPTS_DIR/install_zsh.sh

# Add modifications to .bashrc
$SCRIPTS_DIR/update_bashrc.sh

# Install repositiories
$SCRIPTS_DIR/install_repositories.sh

# Install applications from package-list
$SCRIPTS_DIR/install_packages.sh

# Setup git
$SCRIPTS_DIR/setup_git.sh

# Install Unity, Materia theme and Pop icons
$SCRIPTS_DIR/install_unity.sh

# Update templates
$SCRIPTS_DIR/update_templates.sh

# Setup bitcoin shortcuts
$SCRIPTS_DIR//home/vid/ubuntu-start/scripts/setup_bitcoin_shortcuts.sh

echo Done!

exit 0






























echo "Adding open as root menu to nautilus"
sudo bash -c "$SCRIPTS_DIR/nautilusRoot.sh"









# Themes an icons
echo "Checking for icons and themes"
if [ ! -d "/home/$USER/.icons/Graphite-icons" ]; then
	
	while true; do
	read -p "Do you want to install and set graphite theme and icons? (Y/N)?" answer
		case $answer in
	      	[Yy]* ) echo "Running script"
			./setTheme.sh
			break;;
	       	[Nn]* ) echo "NO"; break;;
			* ) echo "Please answer yes or no.";;
	  	esac
	done
else
	echo "Icons already exist"

fi
