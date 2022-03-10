# Creamos las vms del tipo b (vm_size_b)

resource "azurerm_linux_virtual_machine" "vm_b" {
    name                = "${var.prefix}-${var.virtual_machine_name_prefix}-b-${var.vm_count_b[count.index]}"
    count               = length(var.vm_count_b)
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size_b
    admin_username      = "silgonza"
    network_interface_ids = [ azurerm_network_interface.vm_nic_b[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }
	
	os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
    }

    tags = {
        environment = var.environment
    }	
}
