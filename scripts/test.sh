
FILENAME=package-list2
ERROR=1

if [ ! -f /home/$USER/log/install-apps.log ]
then
    install -D /home/$USER/log/
fi

FILENAME=package-list2

ERROR_PKG=""

#cat $FILENAME |
while read -r line
do
    sh -c 'sudo apt-get install $line'
    #sudo apt-get install $line
        
    APT_ERROR=$?
        
    if [ APT_ERROR != 0 ]; then
        echo "ERROR in line $line"
        echo "ERROR in line $line" >> /home/$USER/log/install-apps.log
                        
        ERROR_PKG="$ERROR_PKG"$'\n'$line
           
    fi
done < $FILENAME
	
echo "$(date)" >> /home/$USER/log/install-apps.log
echo "The following programs did not install"$'\n' "$ERROR_PKG" >> /home/$USER/log/install-apps.log
echo "For log see /home/$USER/log/install-apps.log"
#echo "$ERROR_PKG2"
