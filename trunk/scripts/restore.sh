#! /bin/bash



settings=$(cat backup/gsettings)

echo "$settings" | while read -r line
do
	echo "Setting: $line"	
	gsettings set $line	
done

echo "Setting ccsm settings"
./ccsm-import.py backup/ccsm-settings.profile



