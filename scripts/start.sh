#!/bin/bash

# UBUNtU-TWEAK note: this is a natty repo!
#  sudo add-apt-repository 'deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu natty main'

clear

cur_dir=$(find `pwd` -name "scripts")

sudo chmod +x $cur_dir/*

touch touch

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

#Disable/enable scrollbar overlay
sh $cur_dir/scrollbarOverlay.sh


while true; do
    read -p "Do you want to add a bunch of repos (Y/N)?" answer
    case $answer in
	  [Yy]* ) 

    
    sudo add-apt-repository ppa:thefanclub/grive-tools   # Grive, google drive client
    sudo add-apt-repository ppa:jd-team/jdownloader -y
    sudo add-apt-repository ppa:nae-team/ppa -y
    sudo add-apt-repository ppa:rabbitvcs/ppa -y    #SVN nautilus stuff
    sudo add-apt-repository ppa:flozz/flozz    -y     # nautilus-terminal
    sudo add-apt-repository ppa:noobslab/apps   -y    #open-as-administrator 
    sudo add-apt-repository ppa:daniel.pavel/solaar -y #Sollar, tool for logitech unigying receicers  
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

      sudo apt-get update
      sudo apt-get install retext -y
      sudo apt-get install grive-tools -y
      sudo apt-get install ubuntu-tweak -y
      sudo apt-get install google-chrome-stable -y
      sudo apt-get install nautilus-dropbox -y
      
      sudo apt-get install terminator -y
      sudo apt-get remove gnome-terminal
      sudo ln -s /usr/bin/terminator /usr/bin/gnome-terminal
      
      sudo apt-get install jdownloader -y
      sudo apt-get install ubuntu-restricted-extras -y
      sudo apt-get install skype -y
      sudo apt-get install compizconfig-settings-manager -y
      sudo apt-get install compiz-plugins-extra -y
      #sudo apt-get install nautilus-actions -y
      #sudo apt-get remove  banshee -y
      #sudo apt-get install rhythmbox -y
      sudo apt-get install mountmanager -y
      sudo apt-get install xoscope -y
      sudo apt-get install wine -y
      sudo apt-get install flashplugin-installer -y
      sudo apt-get install vlc -y
      sudo apt-get install unetbootin -y
      sudo apt-get install fdupes -y
      #sudo  apt-get install gnome-panel -y
      sudo apt-get install tuxguitar timidity tuxguitar-jsa -y
      #sudo  apt-get install drawers -y
      sudo apt-get install dayfolder -y
      #sudo  apt-get install myagenda -y
      sudo apt-get install sl -y
      
      #nautilus

      sudo apt-get install nautilus-actions-extra -y
      sudo apt-get install nautilus-open-terminal -y
      sudo apt-get install nautilus-image-converter -y
      sudo apt-get install nautilus-actions -y
      sudo apt-get install nautilus-scripts-manager -y
      
      sudo apt-get install rabbitvcs-cli -y rabbitvcs-core -y rabbitvcs-gedit -y rabbitvcs-nautilus3 -y

      sudo apt-get install aptitude -y
      sudo apt-get install git -y
      sudo apt-get install qbittorrent -y
      sudo apt-get install gconf-editor -y
      sudo apt-get install startupmanager -y
      sudo apt-get install dconf-tools -y
      #sudo  apt-get install indicator-weather -y
      sudo apt-get install indicator-multiload -y
      sudo apt-get install compiz-fusion-plugins-apt -y
      #sudo apt-get install gnome-pie -y
      #sudo apt-get install myunity -y
      sudo apt-get install gimp -y
      sudo apt-get install clementine -y
      sudo apt-get install calibre -y

      sudo apt-get install build-essential -y
      sudo apt-get install cmake -y
      sudo apt-get install subversion -y
      sudo apt-get install libgtk2.0-dev -y
      sudo apt-get install pkg-config -y
      sudo apt-get install libjpeg-dev -y
      sudo apt-get install python-dev -y
      sudo apt-get install yasm -y
      sudo apt-get install openshot openshot-doc -y
      sudo apt-get install minitube -y
      sudo apt-get install pinta -y
      sudo apt-get install picasa -y
      sudo apt-get install dia -y
      sudo apt-get install xsane -y
      sudo apt-get install stellarium -y
      sudo apt-get install xbmc -y
      sudo apt-get install screenlets -y
      sudo apt-get install screenlets-pack-all -y
      sudo apt-get install kid3-qt -y
      sudo apt-get install tagtool -y
      sudo apt-get install gpointing-device-settings -y
      sudo apt-get install solaar -y

      #RUN PROGRAMS
      indicator-weather &
      indicator-multiload &

      break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


echo Done!
