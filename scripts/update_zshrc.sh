#!/bin/bash

SCRIPTS_DIR=$(find `pwd` -name "scripts")


echo "This will update .zshrc"

if [ -f /home/$USER/.zshrc ];
then
   	echo "File .zshrc exists. "

	echo "Adding modifications to zshrc"
	if grep "Added by bashrc-add.sh" /home/$USER/.zshrc ; then
		echo ".zshrc already contains modifications from this script."
	else
		while true; do
	    	read -p "Do you want to add modifications to .zshrc? (Y/N)?" answer
	    		case $answer in
			[Yy]* ) echo "Running zshrc script"
				$SCRIPTS_DIR/bashrc-add.sh /home/$USER/.zshrc
	 			break;;
			[Nn]* ) echo "NO"; break;;
			* ) echo "Please answer yes or no.";;
	    		esac
		done
	fi
else
  	echo "File .zshrc does not exist."
fi
