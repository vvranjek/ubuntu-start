#!/bin/bash




for i in "$@"
do
case $i in
    -p=*|--extension=*)
    PROJECT_NAME="${i#*=}"
    #FILENAME=tradfri_$PROJECT
    echo Project:$PROJECT_NAME
    shift # past argument=value
    ;;
    -s=*|--searchpath=*)
    #
    shift # past argument=value
    ;;

esac
done



if [ ! -z "$PROJECT_NAME" ]; then
    ARG_FILE=app/builder/$PROJECT_NAME/$PROJECT_NAME.ewp
else
    ARG_FILE=$1
fi

echo ARG_FILE: $ARG_FILE
echo Basename: $(basename $ARG_FILE)

FILENAME=$(basename $ARG_FILE)
FILENAME_BASE="${FILENAME%.*}"
FILE_PATH="$( cd "$( dirname "$ARG_FILE" )" && pwd )"
FILENAME_FULL=$FILE_PATH/$FILENAME

QT_CONFIG=$FILE_PATH/$FILENAME_BASE.config
QT_FILES=$FILE_PATH/$FILENAME_BASE.files
QT_INCLUDES=$FILE_PATH/$FILENAME_BASE.includes
QT_CREATOR=$FILE_PATH/$FILENAME_BASE.creator



echo FILE_PATH: $FILE_PATH
echo FILENAME: $FILENAME
echo FILENAME_FULL: $FILENAME_FULL
echo FILENAME_BASE: $FILENAME_BASE
echo QT_CONFIG: $QT_CONFIG
echo QT_FILES: $QT_FILES
echo QT_INCLUDES: $QT_INCLUDES

echo " " > $QT_CONFIG
echo " " > $QT_INCLUDES
echo "[general]" > $QT_CREATOR
echo "$FILENAME_BASE.isc" > $QT_FILES
echo "$FILENAME_BASE.h" >> $QT_FILES





while IFS= read -r line
do
	#printf '%s\n' "$line"
	
	file=""
	line="${line//\\//}"
	
	        
    if [[ $line = *"$PROJ_DIR"* ]]; then
    
		if [[ $line = *".c<"* ]]; then

            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</name)')

            #echo "Source line: $line"
            #echo "Source file: $file"
            echo $file >> $QT_FILES
        
        elif [[ $line = *".h<"* ]]; then
            # Ignore for now
            #echo Line: $line
            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</name)')
            #echo "Header line: $line"
            #echo "Header file: $file"
            
        elif [[ $line = *"="* ]]; then
           
           text=$(echo "$line" | grep -oP '<state>\K.*(?=</state>)')
           
            #echo "Config line: $line"
            #echo "Config file: $file"
            echo "#define $text" >> $QT_CONFIG
            
        elif [[ $line = *".a<"* ]]; then
        
            file=""
        
        elif [[ $line = *"PROJ_DIR"* ]]; then
            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</state)')

            #echo "Include line: $line"
            #echo "Include file: $file"
            echo $file >> $QT_INCLUDES
        fi
    fi
done <"$FILENAME_FULL"


while IFS= read -r line
do
	#printf '%s\n' "$line"
	
	file=""
	line="${line//\\//}"
	
	        
    if [[ $line = *"$PROJ_DIR"* ]]; then
    
		if [[ $line = *".c<"* ]] && [[ $line = *"<name>"* ]]; then

            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</name)')

            #echo "Source line: $line"
            #echo "Source file: $file"
            echo $file >> $QT_FILES
            
        elif [[ $line = *".c<"* ]]  && [[ $line = *"<file>"* ]]; then
 
            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</file)')

            #echo "Source line: $line"
            #echo "Source file: $file"
            #echo $file >> $QT_FILES
        
        elif [[ $line = *".h<"* ]]; then
            # Ignore for now
            file=$(echo "$line" | grep -oP 'PROJ_DIR\$/\K.*(?=</file)')
            #echo "Header line: $line"
            #echo "Header file: $file"
            echo $file >> $QT_FILES
            
        elif [[ $line = *"="* ]]; then
           
            file=$(echo "$line" | grep -oP '<state>\K.*(?=</state>)')
            #echo "Config line: $line"
            #echo "Config file: $file"
            #echo $file >> $QT_CONFIG
        fi
    fi
done < "$FILE_PATH/$FILENAME_BASE.dep"



exit 0


cat $FILENAME_FULL | while read -r line; do
        
    if [[ $line = *"$PROJ_DIR"* ]]; then
    
		if [[ $line = *".c<"* ]]; then
		
            file=$($line | cut -d "PROJ_DIR\$/" -f2 | cut -d "</name" -f1)
            echo "Source file: $file"
            echo $file > $QT_FILES
        
        elif [[ $line = *".h<"* ]]; then
            
            file=$($line | cut -d "PROJ_DIR\$/" -f2 | cut -d "</name" -f1)
            #echo "Header file: $file"
        
        elif [[ $line != *".a<"* ]]; then
        
            file=""
            #echo ".a file"
        fi
    fi
		
		

done








exit 0


asdasdasdadas















cat $FILENAME_FULL | while read -r line; do
        
    if [[ $line = *"$PROJ_DIR"* ]]; then
    
		if [[ $line = *".c<"* ]]; then
		
            file=${$line | cut -d "PROJ_DIR\$/" -f2 | cut -d "</" -f1}
            echo "Source file: $file"
            echo $file > QT_FILES
        
        elif [[ $line = *".h<"* ]]; then
            
            file=${$line | cut -d 'PROJ_DIR\$/' -f2 | cut -d "</" -f1}
            echo "Header file: $file"
        
        elif [[ $line != *".a<"* ]]; then
        
            echo ".a file"
        fi
    fi
		
		

done
