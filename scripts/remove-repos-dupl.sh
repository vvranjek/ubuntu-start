#! /bin/bash


# Read line number i
#line=$(sed -n "${i}p" "$filename")

echo "Warning! This program only removes launchpad repositories."
echo Running apt-get update...
ppa=$(sudo apt-get update 2>&1 >/dev/null | grep ^"W: Duplicate sources.list")

n=0
if [[ -n "$ppa" ]]
then
	echo Found duplicate sources:
	echo "$ppa"

	echo "$ppa" | while read -r line
	do
		echo "Reding line number: $n"	
		echo
		source[n]=$(echo "$line" | grep ^"W: Duplicate" | awk '{split($line, a, " "); print "source: "a[5]}') 
		
		echo "Source[$n] = ${source[$n]}"

		if [ "${source[$n]}" == "$prev_source"] ]
		then
			echo "Same source found in n = $n and n = $n-1"
		fi
		echo
		prev_source=${source[$n]}
		let n+=1
	done
	
	grep -rl http://dl.google.com/linux/chrome/deb/ /etc/apt/sources.list.d




else
	echo "No duplicate sources found."
fi




