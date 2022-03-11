#!/bin/bash

#*************************************************
# Nodo ejecutor de ansible - Ubuntu 20.04 WSL
# Ejecuta 
# *** 1- Seteo zona y reinicio hora
# *** 2- Instalacion chrony
# *** 3- Seteo /etc/hosts local con nodos Azure
#--------------------------------------------------
ansible-playbook -i hosts -l controller setup_controller.yaml -v