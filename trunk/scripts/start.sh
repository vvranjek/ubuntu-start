#!/bin/bash

# UBUNtU-TWEAK note: this is a natty repo!
#  sudo add-apt-repository 'deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu natty main'

clear

cur_dir=$(pwd)

sudo chmod +x *


echo "Hello and welcome to this must have Ubuntu installation script."
sleep 0.5

echo "Creating 'Programs' and 'bin' folders."
mkdir -p /home/$USER/Programs
mkdir -p /home/$USER/bin
sleep 0.3

echo "Copying scripts to bin."
cp -r $cur_dir/. /home/$USER/bin
sudo chmod +x /home/$USER/bin/*
sleep 0.3

echo "Adding $USER to group dialout"
sudo adduser $USER dialout
sleep 0.3

echo "Adding open as root menu to nautilus"
sudo bash -c "$cur_dir/nautilusRoot.sh"
sleep 0.3

echo "Adding modifications to bashrc"
if grep "Added by bashrc-add.sh" /home/$USER/.bashrc ; then
	echo ".bashrc already contains modifications from this script."
else
	while true; do
    	read -p "Do you want to add modifications to .bashrc? (Y/N)?" answer
    		case $answer in
        	[Yy]* ) echo "Running bashrc script"
			./bashrc-add.sh
 			break;;
        	[Nn]* ) echo "NO"; break;;
        	* ) echo "Please answer yes or no.";;
    		esac
	done
fi

echo "Checking for icons and themes"
if [ ! -d "/home/$USER/.icons/Graphite-icons" ]; then
	
	while true; do
	read -p "Do you want to install and set graphite theme and icons? (Y/N)?" answer
		case $answer in
	      	[Yy]* ) echo "Running script"
			./setTheme.sh
			break;;
	       	[Nn]* ) echo "NO"; break;;
			* ) echo "Please answer yes or no.";;
	  	esac
	done
else
	echo "Icons already exist"

fi

sh scrollbarOverlay.sh


while true; do
    read -p "Do you want to add a bunch of repos (Y/N)?" answer
    case $answer in
	  [Yy]* ) 

    
    sudo add-apt-repository ppa:jd-team/jdownloader -y
    sudo add-apt-repository ppa:nae-team/ppa -y
    sudo add-apt-repository ppa:rabbitvcs/ppa -y    #SVN nautilus stuff
    sudo add-apt-repository ppa:flozz/flozz    -y     # nautilus-terminal
    sudo add-apt-repository ppa:noobslab/apps   -y    #open-as-administrator
    #sudo add-apt-repository ppa:gloobus-dev/gloobus-preview -y
    #sudo apt-add-repository ppa:screenlets/ppa -y 		# Scrennlets
    #sudo apt-add-repository ppa:ian-berke/ppa-drawers -y   # Drawers
    #sudo add-apt-repository ppa:thejambi/thejambi -y   # DayFolder
    #sudo add-apt-repository ppa:piotr-zagawa/ma2 -y  # MyAgenda
    
    

    #wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -   #Google chrome repo
    #sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	

    echo "Removing unknow sources"
    ./remove-repos.sh

    break;;
    
    [Nn]* ) echo "NO"; break;;
        * ) echo "Please answer yes or no.";;
    esac
done


while true; do
    read -p "Do you want to install of apps (Y/N)?" answer
    case $answer in
      [Yy]* ) 

      apt-get update
      apt-get install ubuntu-tweak -y
      apt-get install google-chrome-stable -y
      apt-get install nautilus-dropbox -y
      
      apt-get install terminator -y
      sudo apt-get remove gnome-terminal
      sudo ln -s /usr/bin/terminator /usr/bin/gnome-terminal
      
      apt-get install jdownloader -y
      apt-get install ubuntu-restricted-extras -y
      apt-get install skype -y
      apt-get install compizconfig-settings-manager -y
      apt-get install compiz-plugins-extra -y
      #apt-get install nautilus-actions -y
      #apt-get remove  banshee -y
      #apt-get install rhythmbox -y
      apt-get install mountmanager -y
      apt-get install xoscope -y
      apt-get install wine -y
      apt-get install flashplugin-installer -y
      apt-get install vlc -y
      apt-get install unetbootin -y
      apt-get install fdupes -y
      # apt-get install gnome-panel -y
      apt-get install tuxguitar timidity tuxguitar-jsa -y
      # apt-get install drawers -y
      apt-get install dayfolder -y
      # apt-get install myagenda -y
      apt-get install sl -y
      
      #nautilus

      apt-get install nautilus-actions-extra -y
      apt-get install nautilus-open-terminal -y
      apt-get install nautilus-image-converter -y
      apt-get install nautilus-actions -y
      apt-get install nautilus-scripts-manager -y
      
      sudo apt-get install rabbitvcs-cli -y rabbitvcs-core -y rabbitvcs-gedit -y rabbitvcs-nautilus3 -y

      apt-get install aptitude -y
      apt-get install git -y
      apt-get install qbittorrent -y
      apt-get install gconf-editor -y
      apt-get install startupmanager -y
      apt-get install dconf-tools -y
      # apt-get install indicator-weather -y
      apt-get install indicator-multiload -y
      apt-get install compiz-fusion-plugins-apt -y
      #apt-get install gnome-pie -y
      # apt-get install myunity -y
      apt-get install gimp -y
      apt-get install clementine -y
      apt-get install calibre -y

      apt-get install build-essential -y
      apt-get install cmake -y
      apt-get install subversion -y
      apt-get install libgtk2.0-dev -y
      apt-get install pkg-config -y
      apt-get install libjpeg-dev -y
      apt-get install python-dev -y
      apt-get install yasm -y
      apt-get install openshot openshot-doc -y
      apt-get install minitube -y
      apt-get install pinta -y
      apt-get install picasa -y
      apt-get install dia -y
      apt-get install xsane -y
      apt-get install stellarium -y
      apt-get install xbmc -y
      apt-get install screenlets -y
      apt-get install screenlets-pack-all -y
      apt-get install kid3-qt -y
      apt-get install tagtool -y

      #RUN PROGRAMS
      indicator-weather &
      indicator-multiload &

      break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


echo Done!
