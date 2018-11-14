#!/bin/bash

# UBUNtU-TWEAK note: this is a natty repo!
#  sudo add-apt-repository 'deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu natty main'

clear

SCRIPT=`realpath $0`
SCRIPTS_DIR=`dirname $SCRIPT`
#SCRIPTS_DIR=$(find `pwd` -name "scripts")
NAUTILUS_SCRIPTS_DIR=$SCRIPTS_DIR/../nautilus-scripts
FILENAME=$SCRIPTS_DIR/package-list

echo "SCRIPTS_DIR = $SCRIPTS_DIR"
echo "NAUTILUS_SCRIPTS_DIR = $NAUTILUS_SCRIPTS_DIR"
echo "FILENAME = $FILENAME"
sleep 3

sudo chmod +x $SCRIPTS_DIR/*

echo "Hello and welcome to this must have Ubuntu installation script."
sleep 0.5

echo "Creating 'Programs' and 'bin' folders."
mkdir -p /home/$USER/Programs
mkdir -p /home/$USER/bin
sleep 0.3

echo "Creating links of Nautilus scripts"
ln -s $NAUTILUS_SCRIPTS_DIR/* /home/$USER/.local/share/nautilus/scripts/

echo "Creating links of scripts in bin."
ln -s $SCRIPTS_DIR/* /home/$USER/bin/
#cp -r $SCRIPTS_DIR/ /home/$USER/bin
#sudo chmod +x /home/$USER/bin/*
sleep 0.3

echo "Adding $USER to group dialout and sudo"
sudo adduser $USER dialout
sudo adduser $USER sudo
sudo adduser $USER vid
sleep 0.3

echo "Adding open as root menu to nautilus"
sudo bash -c "$SCRIPTS_DIR/nautilusRoot.sh"
sleep 0.3


while true; do
    read -p "Whould you like install ZSH and Oh-My-Zsh? (Y/N)" answer
    case $answer in
      [Yy]* ) 

	sudo apt-get install zsh -y
	wget --no-check-certificate http://install.ohmyz.sh -O - | sh
	chsh -s /bin/zsh $USER
	break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done



if [ -f /home/$USER/.zshrc ];
then
   	echo "File .zshrc exists. "

	echo "Adding modifications to zshrc"
	if grep "Added by bashrc-add.sh" /home/$USER/.zshrc ; then
		echo ".zshrc already contains modifications from this script."
	else
		while true; do
	    	read -p "Do you want to add modifications to .zshrc? (Y/N)?" answer
	    		case $answer in
			[Yy]* ) echo "Running zshrc script"
				$SCRIPTS_DIR/bashrc-add.sh /home/$USER/.zshrc
	 			break;;
			[Nn]* ) echo "NO"; break;;
			* ) echo "Please answer yes or no.";;
	    		esac
		done
	fi
else
  	echo "File .zshrc does not exist."
fi


echo "Adding modifications to bashrc"
if grep "Added by bashrc-add.sh" /home/$USER/.bashrc ; then
	echo ".bashrc already contains modifications from this script."
else
	while true; do
    	read -p "Do you want to add modifications to .bashrc? (Y/N)?" answer
    		case $answer in
        	[Yy]* ) echo "Running bashrc script"
			$SCRIPTS_DIR/bashrc-add.sh /home/$USER/.bashrc
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
sh $SCRIPTS_DIR/scrollbarOverlay.sh


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
    sudo add-apt-repository sudo ppa:nilarimogard/webupd8 -y #Prime indicator 
    sudo add-apt-repository ppa:appgrid/stable -y      #Appgrid
    sudo apt-add-repository ppa:rael-gc/scudcloud -y  # Slack
    sudo apt-add-repository ppa:freecad-maintainers/freecad-stable # FreeCAD


    #sudo add-apt-repository ppa:gloobus-dev/gloobus-preview -y
    #sudo apt-add-repository ppa:screenlets/ppa -y 		# Scrennlets
    #sudo apt-add-repository ppa:ian-berke/ppa-drawers -y   # Drawers
    #sudo add-apt-repository ppa:thejambi/thejambi -y   # DayFolder
    #sudo add-apt-repository ppa:piotr-zagawa/ma2 -y  # MyAgenda
    
    

    #wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -   #Google chrome repo
    #sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	

    echo "Removing unknow sources"
    $SCRIPTS_DIR/remove-repos.sh

    break;;
    
    [Nn]* ) echo "NO"; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Install applications from package-list
while true; do
    read -p "Do you want to install some apps (Y/N)?" answer
    case $answer in
      [Yy]* ) 
	
	cat $FILENAME | while read -r line; do
			# Check for commented lines
			fs="$(echo $line | head -c 1)"

		if [ "$fs" != "#" ]; then
			sudo apt-get install $line -y
		fi
			
		indicator-multiload & disown
	done
	break;;
 		
    [Nn]* ) echo "NO"; break;;
	* ) echo "Please answer yes or no.";;
    esac
done


echo Done!
