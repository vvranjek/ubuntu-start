#! /bin/bash

FILE=$1
SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`

if grep "Added by bashrc-add.sh to $FILE" $FILE ; then
	echo "$FILE already contains modifications from this script."
else if cat $SCRIPTS_DIR/bashrc-content >> $FILE ; then
	echo "Copied bashrc-content to $FILE!"
else
	echo "Something went wrong."
fi
fi













