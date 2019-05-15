#! /bin/bash

DEV=/dev/ttyUSB0
COM=~/.wine/dosdevices/com1
EXE=""

echo
echo "Warning!"
echo "Make sure that your device is connected to $DEV"
echo

# Launch application
wine $EXE &
sleep 2

# Link serial device
echo Removing $COM
rm $COM
echo linking $DEV to $COM
ln -s $DEV $COM   

Echo Done!
