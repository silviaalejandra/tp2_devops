#!/bin/bash

#*************************************************
# Nodo worker KVM - CentOS 8 - Azure
# Ejecuta seteos prerequisitos, seteos de nodos
# e instalcion de kubernetes
#--------------------------------------------------
strDate=`date "+%Y%m%d%H%M%S"`
# Chequeo de fingerprint de llave  = falso
export ANSIBLE_HOST_KEY_CHECKING=False

if [ ! -n "$strLog" -o ! -e $strLog ]
then
	strLog="workers$strDate.log"
fi

# controlo salida por pantalla y log
# exec > >(tee ${strLog} 2>&1)

# Copio el archivo var_hosts desde el controller
# que fue creado con la info de terraform
# despues se pasa al deploy.sh
#strActualDir=`pwd`
#echo $strActualDir
#sudo cp "$strActualDir/roles/init_controller/vars/main/vars_host.yaml" "$strActualDir/roles/prerequisites/vars/main/vars_host.yaml" || true

# ejecuto
echo `date "+%d/%m/%Y %H:%M:%S"`": Inicia seteo de nodo worker con ansible"
ansible-playbook -i hosts -l workers setup_worker.yaml -v
echo `date "+%d/%m/%Y %H:%M:%S"`": Finaliza seteo de nodo worker con ansible"