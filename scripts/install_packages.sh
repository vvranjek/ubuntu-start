#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`
FILENAME=$SCRIPTS_DIR/content/package-list

echo

while true; do
	read -p "Do you want to install applications from package-list (Y/N)?" answer
	case $answer in
	[Yy]* ) echo "Running install_packages.sh"
	####################################### Command ####################################
        sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-restricted-extras
        sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-restricted-addons

        cat $FILENAME | while read -r line; do
            # Check for commented lines
            fs="$(echo $line | head -c 1)"

            if [ "$fs" != "#" ]; then
                sudo apt-get install $line -y
            else
                echo Ignoring commented package $line
            fi
                
            indicator-multiload & disown
        done
	done
	#####################################################################################
	break;;
 		
	[Nn]* ) echo "NO"; break;;
	    * ) echo "Please answer yes or no.";;
	esac 
done
