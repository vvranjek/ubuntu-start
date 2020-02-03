#!/bin/bash

SCRIPTS_DIR=$(find `pwd` -name "scripts")

ADD_LINE="source ~/bin/content/bashrc-content"


echo "This will update .zshrc"

if [ -f /home/$USER/.zshrc ];
then
   	echo "File .zshrc exists. "

	echo "Adding modifications to zshrc"
	if grep "$ADD_LINE" /home/$USER/.zshrc ; then
		echo ".zshrc already contains modifications from this script."
	else
		while true; do
	    	read -p "Do you want to add modifications to .zshrc? (Y/N)?" answer
	    		case $answer in
			[Yy]* ) echo "Running zshrc script"
                echo "$ADD_LINE" >> /home/$USER/.zshrc
	 			break;;
			[Nn]* ) echo "NO"; break;;
			* ) echo "Please answer yes or no.";;
	    		esac
		done
	fi
else
  	echo "File .zshrc does not exist."
fi
