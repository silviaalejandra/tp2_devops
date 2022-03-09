# crea un service principal y rellena los siguientes datos para autenticar
provider "azurerm" {
  features {}
  subscription_id = ${ARM_SUBSCRIPTION_ID}
  tenant_id       = ${ARM_TENANT_ID}
  client_id       = ${ARM_CLIENT_ID}
  client_secret   = ${ARM_CLIENT_SECRET}
}