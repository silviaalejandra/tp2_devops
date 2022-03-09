# Creamos las vms master-nfs-worker01-worker02

resource "azurerm_linux_virtual_machine" "vm" {
    name                = "${var.prefix}-${var.virtual_machine_name_prefix}-${var.vm_count[count.index]}"
    count               = length(var.vm_count)
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    size                = var.vm_size
    admin_username      = "silgonza"
    network_interface_ids = [ azurerm_network_interface.vm_nic[count.index].id ]
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

resource "null_resource" "inventory" {
  count = length(var.vm_count)

  # Generate ansible dynamic inventory python script. 
  # https://jeewansooriyaarachchi.medium.com/run-ansible-playbook-inside-azure-terraform-scripts-76b1dcd72b34
  provisioner "local-exec" {
    command = "./generate_inv.sh $hostname $ip"
    environment = {
      hostname = "${element(azurerm_linux_virtual_machine.vm[count.index].*.name, count.index)}"
      ip = "${element(azurerm_linux_virtual_machine.vm[count.index].*.private_ip_address, count.index)}"
    }
  }
  
  # Run the ansible playbook
  #provisioner "local-exec" {
  #  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i $file resolv_correction.yml"
  #  environment = {
  #    file = "/tmp/${element(azurerm_linux_virtual_machine.vm[count.index].*.name, count.index)}.py"
  #  }
  #}

  # Delete the temporarily script file created in above step
  #provisioner "local-exec" {
  #  command = "rm -f $file"
  #  environment = {
  #    file = "/tmp/${element(azurerm_linux_virtual_machine.vm[count.index].*.name, count.index)}.py"
  #  }
  #}

 # depends_on = [
 #   azurerm_linux_virtual_machine.vm[count.index],
 # ]
}