#!/bin/bash

#--------------------------------------------------
# inputs
# --- struser
# ------- <usuario de servicio a crear>
#*************************************************
# Ejecuta pasos requeridos en el nodo de ejecucion
#  de las tareas con ansible y terraform
#--------------------------------------------------
strDate=`date "+%Y%m%d%H%M%S"`
strActualDir=`pwd`
strLog="requisitos_$strDate.log"
#strsudopw=$1
struser=$1

#exec > >(tee ${strLog} 2>&1)

echo "Inico de Ejecucion. " `date "+%d/%m/%Y a las %H:%M:%S hs"`
# Entrada
echo `date "+%d/%m/%Y %H:%M:%S"`": Directorio de trabajo: $strActualDir"

#***********************************************#
# setup entorno local previo a ejecuciones
#***********************************************#
echo `date "+%d/%m/%Y %H:%M:%S"`": Se crea un usuario de servicio '${struser}'"
sudo adduser ${struser} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password --disabled-login
echo "${struser}:${struser}" | sudo chpasswd

echo `date "+%d/%m/%Y %H:%M:%S"`": Actualizamos el usuario '${struser}' para que no requiera pass al ejecutar sudo"
cat > ${struser} <<EOF
# User rules for centos
${struser} ALL=(ALL) NOPASSWD:ALL
EOF

sudo cp ${struser} /etc/sudoers.d/${struser}
sudo chmod 440 /etc/sudoers.d/${struser}

#echo `date "+%d/%m/%Y %H:%M:%S"`": cambiamos al usuario '${struser}'"
#su ${struser}
#echo "$USER"
#cd $strActualDir
sudo cp -r . /home/${struser}/tp2_devops
sudo chown -R /home/${struser}/*

    #* Ansible
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: Ansible"
sudo apt install ansible
	#* Crony
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: Crhony"
sudo apt install chrony
sudo service chrony start
	#* jq
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: jq"
sudo apt install jq
	#* Terraform
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: Terraform"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform
	#* python3
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: Phyton"
sudo apt install python3   
	#* openssh-server
echo `date "+%d/%m/%Y %H:%M:%S"`": ------------ instalamos las aplicaciones requeridas: openssh-server"
sudo apt install openssh-server
sudo service ssh status
sudo service ssh start
    #* ssh-keygen


echo `date "+%d/%m/%Y %H:%M:%S"`": instalamos las aplicaciones requeridas"
echo `date "+%d/%m/%Y %H:%M:%S"`": instalamos las aplicaciones requeridas"
