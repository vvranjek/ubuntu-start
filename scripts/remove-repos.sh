#! /bin/bash


# Read line number i
#line=$(sed -n "${i}p" "$filename")


mkdir -p /home/$USER/log/

echo "Warning! This program only removes launchpad repositories."
echo Running apt-get update...
ppa=$(sudo apt-get update | grep ^"Err:")

echo ppa: $ppa

if [[ -n "$ppa" ]]
then
	echo Found unknown sources:
	echo "$ppa"
	echo "" >> /home/$USER/log/removed-repos.log
	echo "$(date)" >> /home/$USER/log/removed-repos.log
	echo "$ppa" >> /home/$USER/log/removed-repos.log
	echo "Following sources were removed:" >> /home/$USER/log/removed-repos.log

	echo "$ppa" | while read -r line
	do
		echo "Reading line: $line"	
		#echo "$line" | grep ^W | awk '{split($line, a, "/"); print "ppa:"a[4]"/"a[5]}' | xargs sudo add-apt-repository --remove	
		
		#REPO=${(cut -d "=" -f 2 <<< $line)%% *}

		REPO=$(echo $line | cut -d' ' -f2)
		echo Removing repo: $REPO

		sudo add-apt-repository --remove $REPO
		if [ $? == 0 ]
		then
                    echo "$REPO" >> /home/$USER/log/removed-repos.log
                else
                    echo "Error removing source: $REPO"  >> /home/$USER/log/removed-repos.log
                fi
	done
	
	echo "For log see /home/$USER/log/removed-repos.log"
else
	echo "No unknown sources found."
	echo "For log see /home/$USER/log/removed-repos.log"
fi




