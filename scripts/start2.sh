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

    
    sudo add-apt-repository ppa:thefanclub/grive-tools -y   # Grive, google drive client
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

FILENAME=package-list

while true; do
    read -p "Do you want to install of apps (Y/N)?" answer
    case $answer in
      [Yy]* ) 
	
	cat $FILENAME | while read -r line
	do
	      echo line is $line
	done
	

      #RUN PROGRAMS
      indicator-weather &
      indicator-multiload &

      break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


echo Done!
