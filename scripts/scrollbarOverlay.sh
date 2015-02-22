
	while true; do
	    read -p "Do you want to disable scrollbar overlay (Y/N)? To enable press E." answer
	    case $answer in
		[Yy]* ) if  grep "export LIBOVERLAY_SCROLLBAR=0" /etc/X11/Xsession.d/80overlayscrollbars 
			then
				sudo bash -c "echo \"export LIBOVERLAY_SCROLLBAR=0\" > /etc/X11/Xsession.d/80overlayscrollbars"
				echo "Scrollbar overlay disabled"
			else
				echo "Scrollbar allready disabled"
			fi
	 		break;;

		[Nn]* ) echo "No"; break;;

		[Ee]* ) sudo bash -c "echo \"export LIBOVERLAY_SCROLLBAR=1\" > /etc/X11/Xsession.d/80overlayscrollbars"
			echo "Scrollbar overlay enabled"
			break;;

		* ) echo "Please answer yes or no.";;
	    esac
	done
	


