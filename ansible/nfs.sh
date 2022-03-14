#!/bin/bash

#*************************************************
# Nodo nfs KVM - CentOS 8 - Azure
# Ejecuta seteos prerequisitos y configuracion 
# nodo nfs
#--------------------------------------------------
strDate=`date "+%Y%m%d%H%M%S"`
# Chequeo de fingerprint de llave  = falso
export ANSIBLE_HOST_KEY_CHECKING=False

if [ ! -n "$strLog" -o ! -e $strLog ]
then
	strLog="nfs$strDate.log"
fi

# controlo salida por pantalla y log
# exec > >(tee ${strLog} 2>&1)

# Copio el archivo var_hosts desde el controller
# que fue creado con la info de terraform
#strActualDir=`pwd`
#echo $strActualDir
#sudo cp "$strActualDir/roles/init_controller/vars/main/vars_host.yaml" "$strActualDir/roles/prerequisites/vars/main/vars_host.yaml" || true

# ejecuto
echo `date "+%d/%m/%Y %H:%M:%S"`": Inicia seteo de nodo nfs con ansible"
ansible-playbook -i hosts -l nfs setup_nfs.yaml -v
echo `date "+%d/%m/%Y %H:%M:%S"`": Finaliza seteo de nodo nfs con ansible"