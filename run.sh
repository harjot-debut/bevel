#!/bin/bash
##############################################################################################
#  Copyright Accenture. All Rights Reserved.
#
#  SPDX-License-Identifier: Apache-2.0
##############################################################################################

set -e

echo "Starting build process..."


# export VAULT_ADDR='http://192.168.18.177:8200' 
# export VAULT_TOKEN="hvs.Cg6HrMwJ01aP6FVRXwDQz0pJ"

echo "Adding env variables..."
export PATH=/root/bin:$PATH

echo "entered"



#Path to k8s config file
export KUBECONFIG=/home/bevel/build/config

echo $KUBECONFIG

kubectl config view

kubectl cluster-info

echo "Validatin network yaml"
ajv validate -s /home/bevel/platforms/network-schema.json -d /home/bevel/build/network.yaml 


# echo "Running the playbook..."
# exec ansible-playbook -vv /home/bevel/platforms/shared/configuration/site.yaml --inventory-file=/home/bevel/platforms/shared/inventory/ -e "@/home/bevel/build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3' 

echo "Running the playbook..."
exec ansible-playbook -vv /home/bevel/platforms/shared/configuration/site.yaml --inventory-file=/home/bevel/platforms/shared/inventory/ -e "@/home/bevel/build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3' --start-at-task="Setup script for Vault and OS Package Manager" 



# echo "Running the playbook..."
# exec ansible-playbook -vv /home/bevel/platforms/shared/configuration/site.yaml --inventory-file=/home/bevel/platforms/shared/inventory/ -e "@/home/bevel/build/network.yaml" -e 'ansible_python_interpreter=/usr/bin/python3' --start-at-task="Check if Kubernetes-auth already created for Organization" 