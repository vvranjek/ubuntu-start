#! /bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in *
do 
	echo "File: $f"
	mv -i $i `echo $i | tr -s ' ' | tr ' ' '_'`
done
 
IFS=$SAVEIFS

exit 0


# Oneliner
# SAVEIFS=$IFS; IFS=$(echo -en "\n\b"); for i in *; do echo "$f"; mv -i $i `echo $i | tr -s ' ' | tr ' ' '_'`; done; IFS=$SAVEIFS



# Oneliner for uppercase to lowercase
# SAVEIFS=$IFS; IFS=$(echo -en "\n\b"); for i in *; do echo "$i"; mv -i $i `echo $i | tr 'A-Z' 'a-z'`; done; IFS=$SAVEIFS


for i in $( ls | grep [A-Z] ); do mv -i $i `echo $i | tr 'A-Z' 'a-z'`; done


