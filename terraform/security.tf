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

    security_rule {
        name                       = "kubernetes01"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "6443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    
    security_rule {
        name                       = "kubernetes02"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "2379-2380"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "kubernetes03"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "10245-10255"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "kubernetes04"
        priority                   = 1005
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "30000-32767"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "argocd"
        priority                   = 1006
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080-8085"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "PORTS"
        priority                   = 1007
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "25000-65000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "argo2"
        priority                   = 1008
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5556-5558"
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