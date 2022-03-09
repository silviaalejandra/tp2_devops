variable "prefix" {
  default       = "sg"
  description = "The prefix which should be used for all resources in this plan"
}

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "virtual_machine_name_prefix" {
  default       = "vm"
  description   = "Prefix of the vm resources"
}

variable "resource_group_location" {
  default = "westeurope"
  description   = "Location of the resource group."
}

variable "environment" {
  type = string
  description = "Environment tags val"
  default = "TP_02_SILGONZA" 
}

variable "vm_size" { # Deseable 2 CPU, 8 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual generica"
  default = "Standard_A2_v2" # 2 CPU, 4 GB, 20GB HDD 
}

variable "vm_count" { # Listado de VMs a crear - todas mismo tamanio generico
  description = "Lista de maquinas virtuales a crear"
  type = list(string)
  default = ["master", "nfs", "worker01", "worker02"]
}

variable "vm_size_master" { # Deseable 2 CPU, 8 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual Master"
  default = "Standard_F2s_v2" # 2 CPU, 4 GB, 16GB HDD 
}

variable "vm_size_nfs" { # Deseable 2 CPU, 4 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual NFS"
  default = "Standard_F2s_v2" # 2 CPU, 4 GB, 16GB HDD 
}

variable "vm_size_worker" { # Deseable 2 CPU, 4 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual Worker"
  default = "Standard_F2s_v2" # 2 CPU, 4 GB, 16GB HDD 
}

#variable "vm_instances_count" {
#  type        = number
#  description = "# count for nodes"
#}