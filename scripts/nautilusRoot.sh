
if grep "Open as root" /usr/share/applications/nautilus.desktop
then
	echo "Nautilus already contains modifications from this script"
else

	if [ $USER = "root" ]
	then
	
		echo "" >> /usr/share/applications/nautilus.desktop
		echo [Desktop Action Window] >> /usr/share/applications/nautilus.desktop
		echo Name=Open As Root >> /usr/share/applications/nautilus.desktop
		echo Exec=gksudo nautilus >> /usr/share/applications/nautilus.desktop
		echo "OnlyShowIn=Unity;" >> /usr/share/applications/nautilus.desktop
	else
		echo "Please run this program as root."
	fi
fi

