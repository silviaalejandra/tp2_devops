#!/bin/bash

#*************************************************
#
#--------------------------------------------------

# Copio el archivo var_hosts desde el controller
# que fue creado con la info de terraform
strActualDir=`pwd`
echo $strActualDir
sudo cp "$strActualDir/roles/init_controller/vars/main/vars_host.yaml" "$strActualDir/roles/prerequisites/vars/main/vars_host.yaml" || true
