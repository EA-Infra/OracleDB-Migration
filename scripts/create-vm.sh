#!/bin/bash
set -e

RESOURCE_GROUP="rg-oracle"
LOCATION="eastus"
VM_NAME="vmoracle19c"
IMAGE="Oracle:oracle-database-19-3:oracle-database-19-0904:latest"
VM_SIZE="Standard_DS2_v2"
ADMIN_USERNAME="azureuser"
PUBLIC_KEY="$1"

az group create --name $RESOURCE_GROUP --location $LOCATION

az vm create \
  --name $VM_NAME \
  --resource-group $RESOURCE_GROUP \
  --image $IMAGE \
  --size $VM_SIZE \
  --admin-username $ADMIN_USERNAME \
  --ssh-key-value "$PUBLIC_KEY" \
  --public-ip-address-allocation static \
  --public-ip-address-dns-name $VM_NAME

az vm disk attach --name oradata01 --new --resource-group $RESOURCE_GROUP --size-gb 64 --sku StandardSSD_LRS --vm-name $VM_NAME

az network nsg create --resource-group $RESOURCE_GROUP --name "${VM_NAME}NSG"
az network nsg rule create --resource-group $RESOURCE_GROUP --nsg-name "${VM_NAME}NSG" --name allow-oracle --protocol tcp --priority 1001 --destination-port-range 1521

PUBLIC_IP=$(az network public-ip show --resource-group $RESOURCE_GROUP --name "${VM_NAME}PublicIP" --query "ipAddress" --output tsv)
echo "public_ip=$PUBLIC_IP" >> $GITHUB_OUTPUT