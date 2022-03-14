# Instalación de infraestructura sobre Azure para despliegue de Kubernetes

A continuacion se describirán los pasos necesarios y los pre requisitos para el
- Despliegue de infraestructura en Azure con Terraform
- Instalación de Kubernetes en la infraestructura desplegada con Ansible
- Instalacion de la aplicación ArgoCD con Ansible sobre Kubernetes 

Todos los códigos a utilizar están disponibles en su última versión en https://github.com/silviaalejandra/tp2_devops
El repositorio cuenta con la siguiente informacion y ejecutables (Se muestran solo los necesarios para la ejecución de este instructivo de instalación)
```
tp2_devops
├── ansible
│   ├── hosts
│   ├── deploy.sh
│   ├── group_vars
│   │   └── v_host.yaml
├── requisitos.sh
├── startdeploy.sh
└── terraform
    ├── LICENSE
    ├── correccion-vars.tf
    ├── credentials.tf
```
**/ansible/hosts**
Contiene las entradas de los host que se estarán creado durante el proceso definidas por nombre. Una vez finalizada la aplicación de los pre requisitos sobre el entorno local es necesario actualizar el valor de la propiedad con el usuario de servicio proporcionado
```
ansible_user=<usuario servicio creado>
```
**/ansible/deploy.sh**
Si bien todo el proceso de creacion de infraestructura e instalacion de la aplicación lo estaremos realizando con el fichero principal, es posible ejecutar la instalacion de Kubernetes y de AgoCD solo ejecutando desploy.sh.
>IMPORTANTE: El uso de este fichero implica que la plataforma ya se encuentra disponible y generado el archivo /ansible/group_vars/v_host.yaml con las IPs publicas de las VM de Azure

**/requisitos.sh**
Con este fichero estaremos instalando las herramientas necesarias en el entorno local de trabajo para el uso de Terraform y Ansible.
## Licencias 
Las licencias utilizadas por las aplicaciones que estaremos trabajando pueden encontrarse en los siguientes ficheros. El uso de estos productos implica la aceptación de las mismas.
* Terraform: fichero /terraform/LICENSE. **Mozilla Public License**
* Ansible: fichero /ansible/LICENSE. **GNU GENERAL PUBLIC LICENSE**
* ArgoCD: fichero/LICENSE. **Apache License** 
```
tp2_devops
├── ansible
│   ├── LICENSE
├── LICENSE
└── terraform
 │   ├── LICENSE
```
# Requisitos y restricciones
Se entiende como **entorno de trabajo** al equipo desde el cual se ejecutarán todos los ficheros que componen la instalación descripta
Se entiende como **entorno cloud** a la suscripción de Azure que debe estar diponible para la instalación.
## Entorno de trabajo
Se detallan a continuacion las características del equipo entorno de trabajo desde el cual se lanzarán las ejecuciones.
SO Ubuntu 20.04.3 LTS (GNU/Linux 5.10.16.3-microsoft-standard-WSL2 x86_64)
El mismo puede ser generado en cualquier PC con windows siguiendo los pasos de la [página oficial de Microsoft](https://docs.microsoft.com/en-us/windows/wsl/install)

1 - Iniciar sesion en el entorno de trabajo seleccionando la aplicacion "Ubuntu" desde el menú Inicio de Windows. 
> El usuario con el cual se accede tiene la posibilidad de hacer sudo con la contraseña seteada en los pasos de creacion.
<p align="center">
  <img src="images/01.01.step.jpg" />
</p>

2 - Ejecutar el siguiente comando para actualizar los paquetes del equipo. Esto nos permitirá además realizar otras instalaciones previas de herramientas.

```
$ sudo apt update
```

<p align="center">
  <img src="images/01.02.step.jpg" />
</p>
3- Instalar git para clonar el repositorio con los archivos a ejecutar.

```
$ sudo apt install git
```
<p align="center">
  <img src="images/01.03.step.jpg" />
</p>
4 - Clonar el repositorio de trabajo y posicionarse en el directorio de trabajo

```
$ git clone https://github.com/silviaalejandra/tp2_devops.git
$ cd tp2_devops
$ ls -al
```
<p align="center">
  <img src="images/01.04.step.jpg" />
</p>




.
├── README.md
├── ansible
│   ├── LICENSE
│   ├── app_argocd.sh
│   ├── app_argocd.yaml
│   ├── controller.sh
│   ├── deploy.sh
│   ├── group_vars
│   │   ├── kube.yaml
│   │   ├── template_vars_host
│   │   └── v_host.yaml
│   ├── hosts
│   ├── master.sh
│   ├── nfs.sh
│   ├── prerequisites.sh
│   ├── roles
│   │   ├── argocd
│   │   │   ├── defaults
│   │   │   │   └── main.yaml
│   │   │   ├── files
│   │   │   │   ├── 01-customresource.yaml
│   │   │   │   ├── 02-service_account.yaml
│   │   │   │   ├── 03-roles.yaml
│   │   │   │   ├── 04-configmap.yaml
│   │   │   │   ├── 05-secret.yaml
│   │   │   │   ├── 06-service.yaml
│   │   │   │   ├── 07-deployment.yaml
│   │   │   │   ├── 08-statefullset.yaml
│   │   │   │   ├── 09-network.yaml
│   │   │   │   └── argodeployment.yaml
│   │   │   └── tasks
│   │   │       ├── 01-namespace.yaml
│   │   │       ├── 02-setup_files.yaml
│   │   │       ├── 03-config_firewall.yaml
│   │   │       ├── 04-install_argocd.yaml
│   │   │       └── main.yaml
│   │   ├── init_controller
│   │   │   ├── defaults
│   │   │   │   └── main.yaml
│   │   │   ├── tasks
│   │   │   │   ├── 01-setup_controller.yaml
│   │   │   │   └── main.yaml
│   │   │   └── vars
│   │   │       └── template_vars_host
│   │   ├── init_k8snodes
│   │   │   ├── defaults
│   │   │   │   └── main.yaml
│   │   │   ├── files
│   │   │   │   ├── daemon.json
│   │   │   │   ├── k8s.conf
│   │   │   │   └── kubernetes.repo
│   │   │   └── tasks
│   │   │       ├── 01-config_firewall.yaml
│   │   │       ├── 02-swap.yaml
│   │   │       ├── 03-install_docker.yaml
│   │   │       ├── 04-kube.yaml
│   │   │       └── main.yaml
│   │   ├── init_master
│   │   │   ├── defaults
│   │   │   │   └── main.yaml
│   │   │   └── tasks
│   │   │       ├── 01-config_firewall.yaml
│   │   │       ├── 02-admin_kubeadm.yaml
│   │   │       ├── 03-Habilito_kube_root.yaml
│   │   │       ├── 04-azure_SDN.yaml
│   │   │       ├── 05-install_ingress.yaml
│   │   │       ├── 06-restar_host.yaml
│   │   │       └── main.yaml
│   │   ├── init_nfs
│   │   │   └── tasks
│   │   │       ├── 01-install_packages.yaml
│   │   │       ├── 02-config_firewall.yaml
│   │   │       └── main.yaml
│   │   ├── init_workers
│   │   │   ├── defaults
│   │   │   │   └── main.yaml
│   │   │   ├── files
│   │   │   │   └── README
│   │   │   └── tasks
│   │   │       ├── 01-config_firewall.yaml
│   │   │       ├── 02-join_master.yaml
│   │   │       ├── 03-restar_host.yaml
│   │   │       └── main.yaml
│   │   └── prerequisites
│   │       ├── defaults
│   │       │   └── main.yaml
│   │       └── tasks
│   │           ├── 00-update_packs.yaml
│   │           ├── 01-timezone.yaml
│   │           ├── 02-selinux.yaml
│   │           ├── 03-install_packs.yaml
│   │           ├── 04-hosts.yaml
│   │           ├── 05-firewall.yaml
│   │           └── main.yaml
│   ├── setup_controller.yaml
│   ├── setup_master.yaml
│   ├── setup_nfs.yaml
│   ├── setup_prerequisites.yaml
│   ├── setup_worker.yaml
│   └── workers.sh
├── images
│   └── 01.02.step.jpg
├── requisitos.sh
├── startdeploy.sh
└── terraform
    ├── LICENSE
    ├── correccion-vars.tf
    ├── credentials.tf
    ├── generate_inv.sh
    ├── inventory.py
    ├── main.tf
    ├── network.tf
    ├── output.tf
    ├── resolv_correction.yml
    ├── security.tf
    ├── variables.tf
    ├── vm.tf
    ├── vmb.tf
    └── vmc.tf







# TP2_Devops

## Nodo Master

Nodo ubuntu local con user silgonza por defecto el cual accionará de maestro.
Se instalan herramientas y se crea el usuario ansible.
Se instala server ssh.
```
silgonza@DESKTOP-G427733:~$ sudo apt install chrony
silgonza@DESKTOP-G427733:~$ sudo service chrony start
silgonza@DESKTOP-G427733:~$ sudo adduser --home /home/ansible ansible
silgonza@DESKTOP-G427733:~$ sudo passwd ansible
silgonza@DESKTOP-G427733:~$ sudo apt install python3 -
silgonza@DESKTOP-G427733:~$ sudo apt install git
silgonza@DESKTOP-G427733:~$ sudo apt install ansible
silgonza@DESKTOP-G427733:~/tp2_devops/ansible$ sudo apt install openssh-server
silgonza@DESKTOP-G427733:~/tp2_devops/ansible$ sudo service ssh status
silgonza@DESKTOP-G427733:~/tp2_devops/ansible$ sudo service ssh start
```

Se crea el par de llaves para la conexion SSH local.
```
ansible@DESKTOP-G427733:~/.ssh$ ssh-keygen -t rsa -b 4096`
```
Y se copia el .pub generado al usuario silgonza como fichero ~/.ssh/authorized_keys

## Nodo Esclavo

Se crea usuario ansible.
```
[centos@ip-172-31-89-245 home]$ sudo adduser -md /home/ansible ansible
[centos@ip-172-31-89-245 home]$ sudo passwd ansible
[centos@ip-172-31-89-245 home]$ su ansible
[ansible@ip-172-31-89-245 ~]$ mkdir /home/ansible/.ssh
[ansible@ip-172-31-89-245 ~]$ chmod 700 .ssh

```

Se instalan herramientas. Chrony ya viene con la imágen de Centos elegida para AWS (Utilizada para la prueba)
Las imágenes centos de AWS fueron seleccionadas por recomendacion desde https://wiki.centos.org/Cloud/AWS
```
centos@ip-172-31-89-245 home]$ sudo systemctl enable chronyd
centos@ip-172-31-89-245 home]$ sudo yum install python3 -y
centos@ip-172-31-89-245 home]$ sudo yum install git ansible -y
```

Para el caso de AWS, al trabajar en el lab del caso práctico1, se reutiliza el par de claves que se carga al generar la imágen (vockey), con lo cual se copia en el usr ansible previamente creado el fichero .ssh/authorized_keys del usuario centos.
```
[centos@ip-172-31-89-245 .ssh]$ sudo cp authorized_keys /home/ansible/.ssh/authorized_keys
[centos@ip-172-31-89-245 .ssh]$ sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
```

Se da permisos al usuario ansible haciendo copia del archivo que trae por defecto la imágen para otorgar permisos al usuario centos
```
[root@ip-172-31-82-119 sudoers.d]# cp 90-cloud-init-users ansible
[root@ip-172-31-82-119 sudoers.d]# ls
90-cloud-init-users  ansible
[root@ip-172-31-82-119 sudoers.d]# vi ansible
[root@ip-172-31-82-119 sudoers.d]# cat ansible
# Created by cloud-init v. 19.4 on Fri, 04 Mar 2022 19:21:53 +0000

# User rules for centos
ansible ALL=(ALL) NOPASSWD:ALL
```

## Prueba conectividad

Luego de armado el archivo /ansible/hosts de ansible:

Se clona repo en la pc maestra con archivos de ansible y se prueba conectividad. Se trabaja desde el usuario ansible.
```
ansible@DESKTOP-G427733:~$ git clone https://github.com/silviaalejandra/tp2_devops.git
ansible@DESKTOP-G427733:~/tp2_devops$ git branch lablocal
ansible@DESKTOP-G427733:~/tp2_devops$ git pull origin lablocal

ansible@DESKTOP-G427733:~/tp2_devops/ansible$ ansible -i hosts -m ping all
DESKTOP-G427733 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
18.233.155.128 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```