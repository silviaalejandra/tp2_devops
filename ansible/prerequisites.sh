#!/bin/bash

#*************************************************
# Nodo ejecutor de ansible - Ubuntu 20.04 WSL
# Ejecuta 
# *** 1- Seteo zona y reinicio hora
# *** 2- Instalacion chrony
# *** 3- Seteo /etc/hosts local con nodos Azure
#--------------------------------------------------
strDate=`date "+%Y%m%d%H%M%S"`
# Chequeo de fingerprint de llave  = falso
export ANSIBLE_HOST_KEY_CHECKING=False

if [ ! -n "$strLog" -o ! -e $strLog ]
then
	strLog="prerequisites_$strDate.log"
fi

# controlo salida por pantalla y log
# exec > >(tee ${strLog} 2>&1)

echo `date "+%d/%m/%Y %H:%M:%S"`": Inicia seteo de pre requisitos en nodos que aplica"
ansible-playbook -i hosts -l updatepaqs setup_prerequisites.yaml -v #--ssh-common-args='-o StrictHostKeyChecking=no'
echo `date "+%d/%m/%Y %H:%M:%S"`": Finaliza seteo de pre requisitos en nodos que aplica"