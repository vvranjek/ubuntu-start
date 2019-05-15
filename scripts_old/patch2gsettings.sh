#!/bin/bash



cat $1 | while read -r line; do
	# Check for commented lines
		fs=${line:0:1}
		if [ "$fs" == "+" ]; then
			GSET_LINE=${line:1:99}
			echo $GSET_LINE
			echo $GSET_LINE >> $1.gset
		fi
	done

echo Done!
