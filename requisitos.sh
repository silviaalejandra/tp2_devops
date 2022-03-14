#!/bin/bash

#--------------------------------------------------
# inputs
# --- strsudopw
# ------- <password del usuario para sudo>
#*************************************************
# Ejecuta pasos requeridos en el nodo de ejecucion
#  de las tareas con ansible y terraform
#--------------------------------------------------
strDate=`date "+%Y%m%d%H%M%S"`
strActualDir=`pwd`
strLog="requisitos_$strDate.log"
strsudopw=$1
struser='prueba5'

exec > >(tee ${strLog} 2>&1)

echo "Inico de Ejecucion. " `date "+%d/%m/%Y a las %H:%M:%S hs"`
# Entrada
echo `date "+%d/%m/%Y %H:%M:%S"`": Directorio de trabajo: $strActualDir"

#***********************************************#
# setup entorno local previo a ejecuciones
#***********************************************#
echo `date "+%d/%m/%Y %H:%M:%S"`": Se crea un usuario de servicio '${struser}'"
echo "${strsudopw}" | sudo adduser ${struser} --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password --disabled-login
echo "${struser}:${struser}" | sudo chpasswd

echo `date "+%d/%m/%Y %H:%M:%S"`": Actualizamos el usuario '${struser}' para que no requiera pass al ejecutar sudo"
cat > ${struser} <<EOF
# User rules for centos
${struser} ALL=(ALL) NOPASSWD:ALL
EOF

echo "${strsudopw}" | sudo cp ${struser} /etc/sudoers.d/${struser}
echo "${strsudopw}" | sudo chmod 440 /etc/sudoers.d/${struser}

echo `date "+%d/%m/%Y %H:%M:%S"`": cambiamos al usuario '${struser}'"
echo "${struser}" | su ${struser}
echo "$USER"
cd $strActualDir

echo `date "+%d/%m/%Y %H:%M:%S"`": instalamos las aplicaciones requeridas"
echo `date "+%d/%m/%Y %H:%M:%S"`": instalamos las aplicaciones requeridas"
echo `date "+%d/%m/%Y %H:%M:%S"`": instalamos las aplicaciones requeridas"
