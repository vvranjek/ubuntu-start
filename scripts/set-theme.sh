#!/bin/bash

THEMES_DIR=$(find `pwd` -name "Themes")
ICONS_DIR=$(find `pwd` -name "Icons")

############### Get the directory of original script, not the link

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done

DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
echo Script location: $DIR


if [ $USER = "root" ]
then
	echo "\n\nDo not use sudo! Please run the script as a current user..\n"
	read -p "Press ENTER to exit..." answer
else

	cp -R $DIR/../config/. ~/.config

	LOG="";
	OVERWRITE_CONFIG="true"

	echo "Installing theme"
	##sudo add-apt-repository ppa:numix/ppa -y
	sudo add-apt-repository ppa:system76/pop -y
	sudo add-apt-repository ppa:noobslab/themes -y

	if ! sudo apt-get install ubuntu-unity-desktop -y; then LOG=$LOG"\\n\\tubuntu-unity-desktop"; fi 
	if ! sudo apt-get install materia-gtk-theme -y; then LOG=$LOG"\\n\\tmateria-gtk-theme"; fi
	if ! sudo apt-get install pop-gtk-theme -y; then LOG=$LOG"\\n\\tpop-gtk-theme"; fi
	if ! sudo apt-get install pop-icon-theme -y; then LOG=$LOG"\\n\\tpop-icon-theme"; fi
	if ! sudo apt-get install system76f-wallpapers -y; then LOG=$LOG"\\n\\tsystem76-wallpapers"; fi

	if [ $LOG ]; then
		echo -e "\\nWARNING: The following did not install $LOG"
		
		while true; do
		read -p "Do you still want to overwrite config files? It may resaoult in a broken theme.(Y/N)?" answer
			case $answer in
	      		[Yy]* ) echo "Yes"
				break;;
	       		[Nn]* ) echo "NO"; 
				OVERWRITE_CONFIG="false"
				break;;
			* ) echo "Please answer yes or no.";;
	  	esac
	done
	fi

	if [ $OVERWRITE_CONFIG == "true" ]; then
		echo "Copying .config" 
		cp -R $DIR/../config/. ~/.config
	fi
		
	
fi

echo Done

exit 0


#read -p "Press ENTER to exit..." answer
