#! /bin/bash

echo

while true; do
	read -p "Do you want to setup Git for Vid Vranjek(Y/N)?" answer
	case $answer in
	[Yy]* ) echo "Running setup_git.sh"
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

exit 0




