output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "vm_ip" {
    #count = length(var.vm_count)
    #name = azurerm_linux_virtual_machine.vm[0].*.name
    #.private_ip_address
    value = azurerm_linux_virtual_machine.vm[0].*
    sensitive = true
}

output "vm_b_ip" {
    #count = length(var.vm_count)
    #name = azurerm_linux_virtual_machine.vm_b[length(var.vm_count_b).index].*.name
    value = azurerm_linux_virtual_machine.vm_b[0].*
    sensitive = true
}

output "vm_c_ip" {
    #count = length(var.vm_count)
    #name = azurerm_linux_virtual_machine.vm_b[length(var.vm_count_c).index].*.name
    value = azurerm_linux_virtual_machine.vm_b[0].*
    sensitive = true
}