#!/bin/bash

#*************************************************
# Nodo nfs KVM - CentOS 8 - Azure
# Ejecuta 
# *** 1- Seteo zona y reinicio hora y chrony
# *** 2- Inactivacion selinux
# *** 3- Instalacion paquetes adicionales
#          (nfs-utils,nfs4-acl-tools,wget)
# *** 4- Actualizacion hosts
# *** 5- Configuracion firewalld
#--------------------------------------------------

# Copio el archivo var_hosts desde el controller
# que fue creado con la info de terraform
strActualDir=`pwd`
echo $strActualDir
sudo cp "$strActualDir/roles/init_controller/vars/main/vars_host.yaml" "$strActualDir/roles/prerequisites/vars/main/vars_host.yaml" || true

# ejecuto
ansible-playbook -i hosts -l nfs setup_nfs.yaml -v