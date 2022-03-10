# Security group
resource "azurerm_network_security_group" "security_group" {
    name                =  "${var.prefix}-sshtraffictp"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = var.environment
    }
}

# Vinculamos el security group al interface de red de los nodos
resource "azurerm_network_interface_security_group_association" "sec_group_assoc" {
    count                     = length(var.vm_count)
    network_interface_id      = azurerm_network_interface.vm_nic[count.index].id
    network_security_group_id = azurerm_network_security_group.security_group.id
}

resource "azurerm_network_interface_security_group_association" "sec_group_assoc_b" {
    count                     = length(var.vm_count_b)
    network_interface_id      = azurerm_network_interface.vm_nic_b[count.index].id
    network_security_group_id = azurerm_network_security_group.security_group.id
}

resource "azurerm_network_interface_security_group_association" "sec_group_assoc_c" {
    count                     = length(var.vm_count_c)
    network_interface_id      = azurerm_network_interface.vm_nic_c[count.index].id
    network_security_group_id = azurerm_network_security_group.security_group.id
}