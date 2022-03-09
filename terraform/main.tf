terraform {
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.46"
    }
  }
}

# Se genera un nombre aleatoreo
#resource "random_pet" "rg-name" {
#  prefix    = var.resource_group_name_prefix
#}

resource "azurerm_resource_group" "rg" {
  name      = "${var.prefix}-resourcegrouptp-${var.resource_group_name_prefix}"
  location  = var.location

  tags = {
    environment = var.environment
  }
}