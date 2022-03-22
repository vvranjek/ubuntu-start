#!/bin/bash


CURRENT_DIR=`pwd`

mkdir -p ~/temp
cd ~/temp
sudo apt install cargo libclang-dev libudev-dev git curl -y
git clone https://gitlab.com/asus-linux/asusctl
cd asusctl
make
sudo make install
cd $CURRENT_DIR
