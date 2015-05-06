#! /bin/bash


# Read line number i
#line=$(sed -n "${i}p" "$filename")

echo "Warning! This program only removes launchpad repositories."
echo Running apt-get update...
ppa=$(sudo apt-get update 2>&1 >/dev/null | grep ^"W: Failed to fetch")

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
		#echo "Reding line: $line"	
		echo "$line" | grep ^W | awk '{split($line, a, "/"); print "ppa:"a[4]"/"a[5]}' | xargs sudo add-apt-repository --remove	
		
		echo "$line" >> /home/$USER/log/removed-repos.log
	done
else
	echo "No unknown sources found."
fi




