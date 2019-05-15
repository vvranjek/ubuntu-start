#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`


echo

# Install and setup zsh
while true; do
    read -p "Whould you like install ZSH and Oh-My-Zsh? (Y/N)" answer
    case $answer in
    [Yy]* ) 
        ##################### Command #######################
        sudo apt-get install git -y
        sudo apt-get install zsh -y
        wget --no-check-certificate http://install.ohmyz.sh -O - | sh
        chsh -s /bin/zsh $USER

        $SCRIPTS_DIR/update_zshrc.sh
        #####################################################
        break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


