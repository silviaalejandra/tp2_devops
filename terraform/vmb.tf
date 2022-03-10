# Creamos las vms del tipo b (vm_size_b)

resource "azurerm_linux_virtual_machine" "vm_b" {
    name                = "${var.prefix}-${var.virtual_machine_name_prefix}-b-${var.vm_count_b[count.index]}"
    count               = length(var.vm_count_b)
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size_b
    admin_username      = var.ssh_user
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

#    provisioner "file" {
#        connection {
#            type = "ssh"
#            user = var.ssh_user
#            host = azurerm_public_ip.public_ip_b[count.index].fqdn
#            agent = false
#            #private_key = file(var.public_key_path)
#            timeout = "5m"
#        }
#        source = "localexec/bin"
#        destination = "/tmp/localexec"
#    }

    # creo usuario ansible y paso la key de conexion ssh
    #provisioner "remote-exec" {
        #host = azurerm_public_ip.public_ip_b[count.index].fqdn    
        #inline = [
    #      "sudo adduser -md /home/ansible ansible && sudo passwd ansible",
    #      "sudo mkdir /home/ansible/.ssh && sudo chmod 700 /home/ansible/.ssh && sudo chown ansible:ansible /home/ansible/.ssh",
    #      "sudo cp /tmp/id_rsa.pub /home/ansible/.ssh/id_rsa.pub && sudo chmod 600 /home/ansible/.ssh/id_rsa.pub && sudo chown ansible:ansible /home/ansible/id_rsa.pub.ssh"
    #    ]
    #}
    # creo usuario ansible y paso la key de conexion ssh
#    provisioner "local-exec" {
#        command = "sh /tmp/localexec/prepare_node.sh ${var.ssh_user}"
#    }
}