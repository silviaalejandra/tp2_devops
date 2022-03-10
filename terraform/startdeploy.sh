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
	terraform plan -destroy -out=main.tfdestroy
	terraform apply main.tfdestroy
	echo `date "+%d/%m/%Y %H:%M:%S"`": terraform fin"
	#exit 0
	echo 0
	return
else 
	if [ "$inTerOption" = "A" ]
	then
		# Initialise the configuration
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform init"
		terraform init -input=false
		# Plan and deploy
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform plan y deploy"
		terraform plan -input=false -out=main.tfplan
		terraform apply main.tfplan
		echo `date "+%d/%m/%Y %H:%M:%S"`": terraform fin"
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

var_vm_count=`terraform output -json vm_a_count | jq -r`
#echo "count a: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	var_vm_a_ip=`terraform output -json vm_a_ip_p | jq -r '.['$var_vm_count']'`
	#echo $var_vm_a_ip
done

var_vm_count=`terraform output -json vm_b_count | jq -r`
#echo "count b: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	var_vm_b_ip=`terraform output -json vm_b_ip_p | jq -r '.['$var_vm_count']'`
	#echo $var_vm_b_ip
done

var_vm_count=`terraform output -json vm_c_count | jq -r`
#echo "count c: $var_vm_count"
while [ $var_vm_count -gt 0 ]
do 
	var_vm_count=$var_vm_count-1
	var_vm_c_ip=`terraform output -json vm_c_ip_p | jq -r '.['$var_vm_count']'`
	#echo $var_vm_c_ip
done
return 