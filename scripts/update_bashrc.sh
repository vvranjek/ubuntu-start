#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`


echo

if grep "Added by bashrc-add.sh" /home/$USER/.bashrc ; then
	echo ".bashrc already contains modifications from this script."
else
	while true; do
    	read -p "Do you want to add modifications to .bashrc? (Y/N)?" answer
    		case $answer in
        	[Yy]* ) echo "Running bashrc script"
        	############################### Command ##################################
			if [ -f /home/$USER/.bashrc ];
            then
                echo "File .bashrc exists. "

                echo "Adding modifications to bashrcc"
                if grep "Added by bashrc-add.sh" /home/$USER/.bashrc ; then
                    echo ".bashrc already contains modifications from this script."
                else
                    while true; do
                        read -p "Do you want to add modifications to .bashrc? (Y/N)?" answer
                            case $answer in
                            [Yy]* ) echo "Running bashrc script"
                            $SCRIPTS_DIR/bashrc-add.sh /home/$USER/.bashrc
                            break;;
                            [Nn]* ) echo "NO"; break;;
                            * ) echo "Please answer yes or no.";;
                            esac
                    done
                fi
            else
                echo "File .bashrc does not exist."
            fi
            ##########################################################################
 			break;;
        	[Nn]* ) echo "NO"; break;;
        	* ) echo "Please answer yes or no.";;
    		esac
	done
fi

