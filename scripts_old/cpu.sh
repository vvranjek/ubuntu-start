#! /bin/bash


let "CORES = $1 - 1"

if [ $2 -eq 0 ]
then
    CORES_ONLINE="offline"
else
    CORES_ONLINE="online"
fi

for (( i=0; i<=CORES; i++ ))
do

	echo "$2 > /sys/devices/system/cpu/cpu$i/online"
	sudo sh -c "echo $2 > /sys/devices/system/cpu/cpu$i/online"
done


echo "Cores 0-$1 $CORES_ONLINE"

echo $tf
