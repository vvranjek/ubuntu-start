
FILENAME=package-list2

ERROR_PKG=""
#ERROR_PKG2="TH\n"

#sudo -u
JOSKE="0"

#cat $FILENAME |
while read -r line
    do
        sh -c 'sudo apt-get install $line'
        #sudo apt-get install $line
        
        APT_ERROR=$?
        
        if [ APT_ERROR != 0 ]; then
            echo "ERROR in line $line"
                        
            ERROR_PKG="$ERROR_PKG"$'\n'$line
           
        fi
    done < $FILENAME
	

echo "The following programs did not install"$'\n' "$ERROR_PKG"
#echo "$ERROR_PKG2"
echo $JOSKE