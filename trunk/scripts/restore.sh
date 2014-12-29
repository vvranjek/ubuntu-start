#! /bin/bash



settings=$(cat ../backup/gsettings)

echo "$settings" | while read -r line
do
	echo "Setting: $line"	
	gsettings set $line	
done

echo "Setting ccsm settings"
if which programname >/dev/null; then
    	echo CCSM found
	./ccsm-import.py backup/ccsm-settings.profile
else
    echo CCSM not installed
    echo Installing ccsm
    sudo bash -c "apt-get install ccsm"
    ./ccsm-import.py ../backup/ccsm-settings.profile
fi




