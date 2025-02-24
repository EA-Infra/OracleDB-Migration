#!/bin/bash
set -e

PUBLIC_IP=$1
VM_NAME="vmoracle19c-demo"
REGION="eastus"

DISK=$(ls -alt /dev/sd* | head -1 | awk '{print $NF}')

sudo parted $DISK mklabel gpt
sudo parted -a optimal $DISB mkpart primary 0GB 64GB
sudo mkfs -t ext4 "${DISK}1"

sudo mkdir /u02
sudo mount "${DISK}1" /u02
sudo chmod 777 /u02

UUID=$(sudo blkid -s UUID -o value "${DISK}1")
echo "UUID=$UUID /u02 ext4 defaults 0 0" | sudo tee -a /etc/fstab

echo "$PUBLIC_IP $VM_NAME.$REGION.cloudapp.azure.com $VM_NAME" | sudo tee -a /etc/hosts

sudo hostnamectl set-hostname "$VM_NAME.$REGION.cloudapp.azure.com"

sudo firewall-cmd --zone=public --add-port=1521/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5502/tcp --permanent
sudo firewall-cmd --reload