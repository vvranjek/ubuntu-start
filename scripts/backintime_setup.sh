#! /bin/bash



# Install dependencies
sudo apt-get install backintime-qt4 -y
sudo apt-get install sshfs

# Create key and send it to QNAP
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub vid@vidcloud.myqnapcloud.com

