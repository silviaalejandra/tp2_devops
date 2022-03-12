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

variable "vm_size" { # NFS Deseable 2 CPU, 4 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual generica"
  default = "Standard_F1" 
}
#Standard_F1    1 CPU, 2 GB, 16GB HDD 
#Standard_B2ms  2 CPU, 8 GB, 16GB HDD 
#Standard_A2_v2 2 CPU, 4 GB, 20GB HDD 
variable "vm_size_b" { # MASTER Deseable 2 CPU, 8 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual generica"
  default = "Standard_B2ms" 
}

variable "vm_size_c" { # WORKERS Deseable 2 CPU, 4 GB, 1x20 HDD
  type = string
  description = "Tamaño de la máquina virtual generica"
  default = "Standard_A2_v2" 
}

# max 9 valores
variable "vm_count" { # Listado de VMs a crear - todas mismo tamanio generico
  description = "Lista de maquinas virtuales a crear"
  type = list(string)
  default = ["nfs"]
}

# max 9 valores
variable "vm_count_b" { # Listado de VMs a crear - todas mismo tamanio generico
  description = "Lista de maquinas virtuales a crear tipo B"
  type = list(string)
  default = ["master"]
}

# max 9 valores
variable "vm_count_c" { # Listado de VMs a crear - todas mismo tamanio generico
  description = "Lista de maquinas virtuales a crear tipo C"
  type = list(string)
  #default = ["worker01", "worker02"]
  default = ["worker01"]
}