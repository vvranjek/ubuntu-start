#!/bin/bash

echo

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
        break;;

	[Nn]* ) echo "NO"; break;;
	    * ) echo "Please answer yes or no.";;
	esac
done


