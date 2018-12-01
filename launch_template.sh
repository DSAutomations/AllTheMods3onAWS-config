#!/bin/bash

# Minimal updates
apt update
sudo apt install -y awscli

# Setup some juicy raw volume (EBS)
mkfs -t ext4 /dev/xvdb
mount /dev/xvdb /mnt

# Create crafter user
adduser crafter --home /mnt/crafter --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "crafter ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Grab and execute server installer as crafter user
cd /mnt/crafter
aws s3 cp s3://mc-server-main-78009249/server-initialize.sh .
chown crafter:crafter server-initialize.sh
chmod +x server-initialize.sh
sudo -H -u crafter ./server-initialize.sh
