#! /bin/bash


INPUT_FILE=$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
TEMP_FILE="$INPUT_FILE_temp"


KNOWN_LINES="\
ThreadRPCServer method
sending
block=
received
current best"


echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | while read filename; do
    INPUT_FILE=$filename
    TEMP_FILE="$INPUT_FILE.temp"
    
    # Don't open files with no name
    if [[ $filename == "" ]]; then
        continue
    fi
        
    #zenity  --info  --text "LIne: $filename."

    touch $TEMP_FILE
    
    $TEMP_FILE > "Log"
    
    LINE_N=1
    
    while IFS= read -r line
    do
        while IFS= read -r known_line
        do
            #echo "Known line: $line"
            if [[ $line == *"$known_line"* ]]; then
                #echo "Found $known_line in: $line"
                echo $LINE_N $line >> $TEMP_FILE
            fi
        done <<< "$KNOWN_LINES"
        LINE_N=$((LINE_N+1))

    done < "$INPUT_FILE"

    gedit $TEMP_FILE
    
done



