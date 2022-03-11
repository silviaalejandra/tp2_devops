#!/bin/bash

#--------------------------------------------------
# inputs
# --- terraform_option (inTerOption)
# ------- values
# ------- A = Apply
# ------- D = Destroy
# --- ansible_option (inAnsOption)
# ------- values
# ------- A = Apply
# ------- D = Destroy
#--------------------------------------------------
inTerOption=${1}
inAnsOption=${2}
strDate=`date "+%Y%m%d%H%M%S"`
strLog="startdeploy$strDate.log"
strActualDir=`pwd`

echo $strActualDir

exec > >(tee ${strLog} 2>&1)

echo "Inico de Ejecucion. " `date "+%d/%m/%Y a las %H:%M:%S hs"`
# Entrada
echo `date "+%d/%m/%Y %H:%M:%S"`": Opcion terraform = $inTerOption"
echo `date "+%d/%m/%Y %H:%M:%S"`": Opcion ansible = $inAnsOption"

# terraform
if [ "$inTerOption" = "D" ]
then
	# Plan and destroy
	echo `date "+%d/%m/%Y %H:%M:%S"`": terraform destroy"
	
	# me muevo al directorio de terraform para trabajar
	cd terraform
	terraform plan -destroy -out=main.tfdestroy
	terraform apply main.tfdestroy
	echo `date "+%d/%m/%Y %H:%M:%S"`": terraform fin"
	
	echo `date "+%d/%m/%Y %H:%M:%S"`": elimino configuraciones asociadas para ansible"
	rm -f $fileHosts || true
	# regreso al dir origen
	cd $strActualDir
	#exit 0
	echo 0
	return
else 
	if [ "$inTerOption" = "A" ]
	then
		# Initialise the configuration
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform init"
		
		# me muevo al directorio de terraform para trabajar
		cd terraform
		terraform init -input=false
		# Plan and deploy
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform plan y deploy"
		terraform plan -input=false -out=main.tfplan
		terraform apply main.tfplan
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform fin"
		
		# regreso al dir origen
		cd $strActualDir
	else
		echo `date "+%d/%m/%Y %H:%M:%S"`": Opcion terraform incorrecta. Verifique y vuelva a intentar"
		#exit 1
		echo "error"
		#return
	fi
fi



# Consulto las IPs de los nodos creados 
declare -i index=0
declare -i var_vm_count=0

# Genero el archivo var_host para el controller
echo `date "+%d/%m/%Y %H:%M:%S"`": Genero el archivo var_host para el controller"
fileTemplate="$strActualDir/ansible/roles/setup_controller/vars/template_vars_host.yaml"
fileHosts="$strActualDir/ansible/roles/setup_controller/vars/vars_host.yaml"
cp $fileTemplate $fileHosts
#echo -e "this is a new line \nthis is another new line" >> file.txt
#  - name: ansible
#    ip: 192.168.122.80
#    name_long: ansible.dm.ar

# me muevo al directorio de terraform para trabajar
cd terraform
echo `date "+%d/%m/%Y %H:%M:%S"`": inicio captura de datos de hosts - grupo a"
var_vm_count=`terraform output -json vm_a_count | jq -r`
#echo "count a: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	name_vm=`terraform output -json vm_a_name | jq -r '.['$var_vm_count']' | awk -F'-' '{print $4}'`
	echo -e "  - name: $name_vm" >> $fileHosts
	ip_vm=`terraform output -json vm_a_ip_p | jq -r '.['$var_vm_count']'`
	echo -e "    ip: $ip_vm" >> $fileHosts
	echo -e "    name_long: $name_vm.silgonza.ar" >> $fileHosts
	#echo $var_vm_a_ip
done

var_vm_count=`terraform output -json vm_b_count | jq -r`
#echo "count b: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	name_vm=`terraform output -json vm_b_name | jq -r '.['$var_vm_count']' | awk -F'-' '{print $4}'`
	echo -e "  - name: $name_vm" >> $fileHosts
	ip_vm=`terraform output -json vm_b_ip_p | jq -r '.['$var_vm_count']'`
	echo -e "    ip: $ip_vm" >> $fileHosts
	echo -e "    name_long: $name_vm.silgonza.ar" >> $fileHosts
	#echo $var_vm_b_ip
done

var_vm_count=`terraform output -json vm_c_count | jq -r`
#echo "count c: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	name_vm=`terraform output -json vm_c_name | jq -r '.['$var_vm_count']' | awk -F'-' '{print $4}'`
	echo -e "  - name: $name_vm" >> $fileHosts
	ip_vm=`terraform output -json vm_c_ip_p | jq -r '.['$var_vm_count']'`
	echo -e "    ip: $ip_vm" >> $fileHosts
	echo -e "    name_long: $name_vm.silgonza.ar" >> $fileHosts
	#echo $var_vm_c_ip
done

# regreso al dir origen
	cd $strActualDir
#return 