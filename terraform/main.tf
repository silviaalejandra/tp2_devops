terraform {
  
  required_version = ">=1.1"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.98"
    }
  }
}

resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name      = random_pet.rg-name.id
  location  = var.resource_group_location

  tags = {
    environment = var.environment
  }
}