output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "vm_a_ip" {
    value = azurerm_linux_virtual_machine.vm.*.private_ip_address
    sensitive = false
}

output "vm_b_ip" {
    value = azurerm_linux_virtual_machine.vm_b.*.private_ip_address
    sensitive = false
}

output "vm_c_ip" {
    value = azurerm_linux_virtual_machine.vm_c.*.private_ip_address
    sensitive = false
}

output "vm_c_ip_p" {
    value = azurerm_linux_virtual_machine.vm_c.*.public_ip_address
    sensitive = false
}

output "vm_a_name" {
    value = azurerm_linux_virtual_machine.vm.*.name
    sensitive = false
}

output "vm_b_name" {
    value = azurerm_linux_virtual_machine.vm_b.*.name
    sensitive = false
}

output "vm_c_name" {
    value = azurerm_linux_virtual_machine.vm_c.*.name
    sensitive = false
}

output "vm_a_count" {
    value = length(var.vm_count)
}

output "vm_b_count" {
    value = length(var.vm_count_b)
}

output "vm_c_count" {
    value = length(var.vm_count_c)
}