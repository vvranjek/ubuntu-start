#!bin/bash

echo Press any key to continue...
read -n 1


mkdir /home/$USER/Programs

tar -zhvf pyepics-* -C /home/$USER/Programs/
cd /home/$USER/Programs/pyepics-*

python setup.py install

sudo ln -s /opt/epics/base-*/bin/linux-*/ca* /usr/bin/




 
