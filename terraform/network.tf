# Creacion de red
resource "azurerm_virtual_network" "virtual_network" {
    name                = "${var.prefix}-kubenettp"
    address_space       = ["192.168.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = var.environment
    }
}

# Creacion de subnet
resource "azurerm_subnet" "subnet" {
    name                   = "${var.prefix}-kubesubnettp"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.virtual_network.name
    address_prefixes       = ["192.168.1.0/24"]
}

# Create NIC all vms
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.prefix}-nic-${var.vm_count[count.index]}"
  count               = length(var.vm_count)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "${var.prefix}-ipconfig-${var.vm_count[count.index]}"
    subnet_id                      = azurerm_subnet.subnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "192.168.1.${count.index + 10}" # subnet 192.168.1.0
    public_ip_address_id           = azurerm_public_ip.public_ip[count.index].id
  }

    tags = {
        environment = var.environment
    }
}

# IP publica general
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-publicip-${var.vm_count[count.index]}"
  count               = length(var.vm_count)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = var.environment
    }
}