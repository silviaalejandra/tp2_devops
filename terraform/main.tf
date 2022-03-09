terraform {
  
  required_versions = ">=1.1"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~=2.98"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "2e3b5939-31bd-4d94-8053-5f2b29b1b99c"
  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440"
  client_id       = "ab23ce50-de19-4394-8db8-2549f3280f9d"
  client_secret   = "JT-Rb9-d.RlXNMYQML3PV4KHGH~8oQyLMt"
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