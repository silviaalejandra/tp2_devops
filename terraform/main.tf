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

# Grupo de recursos del TP
resource "azurerm_resource_group" "rg" {
  name      = "${var.prefix}-resourcegrouptp-${var.resource_group_name_prefix}"
  location  = var.location

  tags = {
    environment = var.environment
  }
}

# Storage account
resource "azurerm_storage_account" "storage_account" {
    #name                     = "${var.prefix}${var.storage_account}"
    name                     = var.storage_account
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS" #Locally-Redundant Storage (LRS)

    tags = {
        environment = var.environment
    }

}