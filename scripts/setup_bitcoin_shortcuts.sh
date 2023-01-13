#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`


ADD_LINE="source ~/bitcoin/btcli/btcli-src \nsource btc-shortcuts"


PROFILE_FILE="/home/$USER/.profile"

if [ -f $PROFILE_FILE ]; then
    echo "Adding modifications to $PROFILE_FILE"
    if grep "$ADD_LINE" $PROFILE_FILE ; then
        echo "$PROFILE_FILE already contains modifications from this script."
    else
        while true; do
            read -p "Do you want to add modifications to $PROFILE_FILE? (Y/N)?" answer
                case $answer in
                [Yy]* ) echo "Working..."
                    echo "" >> $PROFILE_FILE
                    echo -e "$ADD_LINE" >> $PROFILE_FILE
                break;;
                [Nn]* ) echo "NO"; break;;
                * ) echo "Please answer yes or no.";;
                esac
        done
        echo Done
    fi
else
    echo "File $PROFILE_FILE does not exist."
fi


