#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`


ADD_LINE="source ~/bin/content/bashrc-content"


echo

if [ -f /home/$USER/.bashrc ]; then
    echo "Adding modifications to bashrcc"
    if grep "$ADD_LINE" /home/$USER/.bashrc ; then
        echo ".bashrc already contains modifications from this script."
    else
        while true; do
            read -p 'Do you want to add modifications to .bashrc? (Y/N)?' answer
                case $answer in
                [Yy]* ) echo "Running bashrc script"
                    echo "$ADD_LINE" >> /home/$USER/.bashrc
                break;;
                [Nn]* ) echo "NO"; break;;
                * ) echo "Please answer yes or no.";;
                esac
        done
    fi
else
    echo 'File .bashrc does not exist.'
fi


