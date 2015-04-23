
FILENAME=package-list2

ERROR_PKG="These are errors\n"
ERROR_PKG2="TH\n"

cat $FILENAME | while read -r line
	do
	      #sudo sh -c 'apt-get install $line'
	      sudo apt-get install $line
	      if [ $? != 0 ]; then
		  echo "ERROR!!!!!!! in line $line"
		  echo $line
		  echo $line
		  echo $line
		  echo $line
		  
		  ERROR_PKG2+="$ERROR_PKG $line"
		  ERROR_PKG="$ERROR_PKG $line"
		  echo "$ERROR_PKG"
		  echo "$ERROR_PKG2"
	      fi
		  
		  
	done
	
	echo "Final line is $line"

	ERROR_PKG2+="$ERROR_PKG2 KVajzddeeeeeeeeeeeeeej"
	ERROR_PKG2+="$ERROR_PKG $line"
	echo "$ERROR_PKG"
	echo "$ERROR_PKG2"