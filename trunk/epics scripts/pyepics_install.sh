#!bin/bash

# Download the base tar file from http://www.aps.anl.gov/epics/download/base/index.php
# Put downloaded tar in the same dir as this script

echo Press any key to continue...
read -n 1

sudo apt-get install readline-dev

mkdir /opt/epics
chown $USER /opt/epics

tar -zhvf $1 -C /opt/epics/

ln -s base-*/ base
cd /opt/epics/base

export MY_EPICS_BASE=/opt/epics/base/
export EPICS_EXTENSIONS=/opt/epics/extensions
export BROWSER=firefox
source startup/Site.profile

make




 
