#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`


echo

# Install and setup zsh
while true; do
    read -p "Whould you like install Slovenian for libreoffice? (Y/N)" answer
    case $answer in
    [Yy]* ) 
        ##################### Command #######################
        echo "Adding Odprti Tezaver to libreoffice"
        sudo unopkg add --shared $SCRIPTS_DIR/../libreoffice/OdprtiTezaver.oxt
        echo "Adding Slovenian pack to libreoffice"
        sudo unopkg add --shared $SCRIPTS_DIR/../libreoffice/pack-sl.oxt

        if [ $? -ne 0 ]
        then
            echo
            #read -n 1 -s -r -p "There was an error installing libreoffice extension. Press any key to continue" 
            read -p "There was an error installing libreoffice extension. Press enter to continue..." answer
            echo
            case $answer in
                * ) break;;
            esac
        fi
        #####################################################
        break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


