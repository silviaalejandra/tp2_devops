# Instalación de infraestructura sobre Azure para despliegue de Kubernetes

A continuacion se describirán los pasos necesarios y los pre requisitos para el
- Despliegue de infraestructura en Azure
- Instalación de Kubernetes en la infraestructura desplegada

Todos los códigos a utilizar están disponibles en su última versión en https://github.com/silviaalejandra/tp2_devops

# Requisitos y restricciones
Se entiende como **entorno de trabajo** al equipo desde el cual se ejecutarán todos los ficheros que componen la instalación descripta
Se entiende como **entorno cloud** a la suscripción de Azure que debe estar diponible para la instalación.
## Entorno de trabajo
Se detallan a continuacion las características del equipo entorno de trabajo desde el cual se lanzarán las ejecuciones.
SO Ubuntu 20.04.3 LTS (GNU/Linux 5.10.16.3-microsoft-standard-WSL2 x86_64)
El mismo puede ser generado en cualquier PC con windows siguiendo los pasos de la [página oficial de Microsoft](https://docs.microsoft.com/en-us/windows/wsl/install)

1 - Iniciar sesion en el entorno de trabajo seleccionando la aplicacion "Ubuntu" desde el menú Inicio de Windows. 
> El usuario con el cual se accede tiene la posibilidad de hacer sudo con la contraseña seteada en los pasos de creacion.

2 - Ejecutar el siguiente comando para actualizar los paquetes del equipo. Esto nos permitirá además realizar otras instalaciones previas de herramientas.
```
$ sudo apt update
```
![APT_UPDATE](imges/01.02.step.jpg)
3- Instalar git para clonar el repositorio con los archivos a ejecutar.
```
$ sudo apt install git
```
4 - Clonar el repositorio de trabajo y posicionarse en el directorio de trabajo
```
$ git clone https://github.com/silviaalejandra/tp2_devops.git
$ cd tp2_devops
$ ls -al







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