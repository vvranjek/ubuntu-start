#! /bin/bash


FILENAME=$(basename "$fullfile")
EXTENSION="${FILENAME##*.}"
FILENAME="${FILENAME%.*}"
ARG_COUNT=$#


if [[ -z $1 ]]; then
	echo Plese specify a file/s
	exit 0
else
	echo "FULL_PATH is $FUL_PATH"
fi

echo "Warning! This script uses a modified bpm-tag script that outputs bpm only (without filename)."
echo "Are you sure you have the correct script? (y/n)"
while true; do
    read  tf
    case $tf in
        [yY]* ) 
		echo True
		
		for (( i=1; i <=$ARG_COUNT; i++ ))
		do
			FILE=${!i}
			#echo $PWD
			echo "Reding file: $FILE"
			
			BPM=$(bpm-tag -f "$FILE")
			echo "BPM = $BPM"
			ERR=$?
			echo "ERR is $ERR"
			
			if [ $ERR -eq 0 ] ; then
				echo "Renaming $FILE"
				#ORIGFILENAME=$(basename "$FILE")
				#echo "Basename = $ORIGFILENAME"
				#EXTENSION="${ORIGFILENAME##*.}"
				EXTENSION="${FILE##*.}"
				FILENAME="${FILE%.*}"
				#echo "Extension: $EXTENSION"
				#echo "Filename: $FILENAME"
				
				#echo "src: "$FUL_PATH/$ORIGFILENAME""
				#echo "dest: "$FUL_PATH/$FILENAME \($BPM bpm\).$EXTENSION" "
				
				#echo "src: "$PWD/$FILE""
				#echo "dest: "$PWD/$FILENAME \($BPM bpm\).$EXTENSION" "
			
				mv "$PWD/$FILE" "$PWD/$FILENAME ($BPM bpm).$EXTENSION"
				echo  
			else
				echo Error $ERR
			fi
		done
		break;;
		
	[nN]* ) echo No 
		break;;
	[] ) break;
    esac
done

echo $tf



