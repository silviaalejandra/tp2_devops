variable "prefix" {
  default       = "sg"
  description = "The prefix which should be used for all resources in this plan"
}

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
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