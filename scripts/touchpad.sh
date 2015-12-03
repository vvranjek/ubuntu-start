#! /bin/bash

touchpad="ETPS/2 Elantech Touchpad"

echo "Setting touchpad settings for $touchpad."

#Synaptics Noise Cancelation
xinput set-prop "$touchpad" "Synaptics Noise Cancellation" 4, 4 

#Pointer speed and acceleration
#xinput set-prop "$touchpad" "Device Accel Velocity Scaling" 1
#xinput set-prop "$touchpad" "Synaptics Move Speed" 1.0, 1.8, 0.8, 0

#Scrolling speed
#xinput set-prop "$touchpad" "Synaptics Scrolling Distance" 60, 60 

#Touchpad working area
#xinput set-prop "$touchpad" "Synaptics Area" 0, 2974, 0, 1700

#Enable two finger vertical scrolling, disable horizontal
xinput set-prop "$touchpad" "Synaptics Two-Finger Scrolling" 1, 0

#Enable palm detection and set reseanoble propeties
xinput set-prop "$touchpad" "Synaptics Palm Detection" 1
xinput set-prop "$touchpad" "Synaptics Palm Dimensions" 5, 10

xinput set-prop "$touchpad" "Synaptics Locked Drags" 1
xinput set-prop "$touchpad" "Synaptics Locked Drags Timeout" 500

#Synapstics Move Speed: min speed, max speed, acc factor, second, trackstick
#xinput set-prop "$touchpad" "Move Speed" 1.5, 1.5, 0.053305, 0



echo "Done!"
