#! /bin/bash

#cat gsettings_vid | while read line
#do
#	echo $line
#done

for i in {0..3521}
do
	line_vid="`sed -n ${i}p gsettings_vid`"
	line_ulu2="`sed -n ${i}p gsettings_ulu2`"
	
	if [ "$line_vid" != "$line_ulu2" ]; then
		echo $line_vid >> gsettings_diff
		echo $line_vid
	fi

	
done


#line4="`sed -n 4p foo.txt`"
