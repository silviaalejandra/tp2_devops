# crea un service principal y rellena los siguientes datos para autenticar
provider "azurerm" {
  features {}
  subscription_id = "2e3b5939-31bd-4d94-8053-5f2b29b1b99c"
  client_id       = "ab23ce50-de19-4394-8db8-2549f3280f9d"         # se obtiene al crear el service principal
  client_secret   = "JT-Rb9-d.RlXNMYQML3PV4KHGH~8oQyLMt"  # se obtiene al crear el service principal
  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440"      # se obtiene al crear el service principal
}