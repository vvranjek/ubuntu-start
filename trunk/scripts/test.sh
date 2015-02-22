
	while true; do
	    read -p "Do you want to disable scrollbar overlay (Y/N)? To enable press E." answer
	    case $answer in
		[Yy]* ) if ! gsettings get com.canonical.desktop.interface scrollbar-mode | grep 'normal'
			then
				gsettings set com.canonical.desktop.interface scrollbar-mode normal
				echo "Scrollbar overlay now disabled"
			else
				echo "Scrollbar allready disabled"
			fi
	 		break;;

		[Nn]* ) echo "No"; break;;

		[Ee]* ) gsettings set com.canonical.desktop.interface scrollbar-mode overlay-auto
			echo "Scrollbar overlay enabled"
			break;;

		* ) echo "Please answer yes or no.";;
	    esac
	done
	


