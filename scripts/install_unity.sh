#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`

echo

while true; do
read -p "Do you want to install and set Unity, Materia theme and Pop icons? (Y/N)?" answer
	case $answer in
    [Yy]* ) 
        echo "This will install Unity, Materia theme and Pop icons"

        #sudo add-apt-repository ppa:numix/ppa -y
        sudo add-apt-repository ppa:system76/pop -y
        sudo add-apt-repository ppa:noobslab/themes -y

        sudo apt-get install ubuntu-unity-desktop -y
        sudo apt-get install materia-gtk-theme -y
        sudo apt-get install pop-gtk-theme -y
        sudo apt-get install pop-icon-theme -y
        sudo apt-get install system76-wallpapers -y
        #sudo apt-get install arrongin-telinkrin-themes

        echo "Setting theme and icons and wallpaper"
        gsettings set org.gnome.desktop.interface gtk-theme "Materia-compact"
        gsettings set org.gnome.desktop.wm.preferences theme "Materia-compact"
        gsettings set org.gnome.desktop.interface icon-theme "Pop"
        gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/System76-Fractal_Mountains-by_Kate_Hazen_of_System76.png'
        gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ background-color '#2e3436ff'
        gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-opacity 0.8045977011494253
        gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ panel-opacity 0.34980988593155893
        gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size 32
        
        break;;
    [Nn]* ) 
        echo "NO"; break;;
    * ) 
        echo "Please answer yes or no.";;
	esac
done



