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

	sudo apt-get install git -y
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

#Disable/enable scrollbar overlay
#sh $SCRIPTS_DIR/scrollbarOverlay.sh


while true; do
	read -p "Do you want to add a bunch of repos (Y/N)?" answer
	case $answer in
	[Yy]* ) 
		sudo add-apt-repository ppa:noobslab/apps   -y    		  #open-as-administrator 
		sudo add-apt-repository ppa:nilarimogard/webupd8 -y 		  #Prime indicator 
		sudo add-apt-repository ppa:appgrid/stable -y      		  #Appgrid
		sudo apt-add-repository ppa:rael-gc/scudcloud -y  		  # Slack
		sudo apt-add-repository ppa:freecad-maintainers/freecad-stable -y # FreeCAD
		sudo add-apt-repository ppa:bit-team/stable -y 			  # Back in time 

		#echo "Removing unknow sources"
		#$SCRIPTS_DIR/remove-repos.sh

		break;;

	[Nn]* ) echo "NO"; break;;
	    * ) echo "Please answer yes or no.";;
	esac
done

# Install applications from package-list
while true; do
	read -p "Do you want to install applications from package-list (Y/N)?" answer
	case $answer in
	[Yy]* ) 
	sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-restricted-extras
	sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ubuntu-restricted-addons	
	cat $FILENAME | while read -r line; do
		# Check for commented lines
		fs="$(echo $line | head -c 1)"

		if [ "$fs" != "#" ]; then
			sudo apt-get install $line -y
		else
			echo Ignoring commented package $line
		fi
			
		indicator-multiload & disown
	done
	break;;
 		
	[Nn]* ) echo "NO"; break;;
	    * ) echo "Please answer yes or no.";;
	esac 
done

# Setup git
while true; do
	read -p "Do you want to setup Git (Y/N)?" answer
	case $answer in
	[Yy]* ) 
		sudo apt-get install git
		name="Vid Vranjek"
		read -p "Enter name [$name]: " input
		name="${input:-$name}"

		email="vidvranjek@gmail.com"
		read -p "Enter email [$email]: " input
		email="${input:-$email}"

		# Git settings
		git config --global user.name "$name"
		git config --global user.email "$email"
		break;;
 		
	[Nn]* ) echo "NO"; break;;
	    * ) echo "Please answer yes or no.";;
	esac 
done
		 

# Themes an icons
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

while true; do
read -p "Do you want to install and set Unity, Materia theme and Pop icons? (Y/N)?" answer
	case $answer in
      	[Yy]* ) echo "Installing theme"
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
       	[Nn]* ) echo "NO"; break;;
		* ) echo "Please answer yes or no.";;
	esac
done


echo Done!

exit 0
