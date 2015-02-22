#! /bin/bash


mkdir /home/$USER/bin
RESULT=$?

if [ $RESULT == 0 ] ; then 
	echo Created folder /home/$USER/bin
else
	echo Folder /home/$USER/bin exists.
fi

if grep "Added by bashrc-add.sh" /home/$USER/.bashrc ; then
	echo ".bashrc already contains modifications from this script."
else if cat bashrc-content >> /home/$USER/.bashrc ; then
	echo "Copied bashrc-content to /home/$USER/.bashrc!"
else
	echo "Something went wrong."
fi
fi













