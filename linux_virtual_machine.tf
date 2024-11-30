
resource "azurerm_linux_virtual_machine" "linux_vm-a" {
  name                = var.azurerm_linux_virtual_machine_name-1
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  location            = azurerm_resource_group.terraform_Lab.location
  size                =  var.azurerm_windows_virtual_machine_size
  admin_username      = var.azurerm_linux_virtual_machine_userName-1
  network_interface_ids = [
    azurerm_network_interface.linux_VM_1_nic.id,
  ]
 depends_on = [ azurerm_subnet.hub_file-share_subnet ]

  admin_ssh_key {
    username   = var.azurerm_linux_virtual_machine_userName-1
    public_key = file("C:/Users/Compurter Store/123.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.azurerm_linux_virtual_machine_publisher
    offer     = var.azurerm_linux_virtual_machine_offer
    sku       = var.azurerm_linux_virtual_machine_SKU
    version   = var.azurerm_linux_virtual_machine_version
  }
  #installing apache && make directoty to file share
  #   custom_data = base64encode(<<EOT
  #     #!/bin/bash
  #     sudo apt update
  #     sudo apt install -y apache2
  #     sudo systemctl enable apache2
  #     sudo systemctl start apache2
  #     sudo mkdir -p /mnt/sharedfiles
  #     sudo mount -t cifs //${azurerm_storage_account.file_share.name}.file.core.windows.net/${azurerm_storage_share.file_share.name} /mnt/sharedfiles -o vers=3.0,username=${azurerm_storage_account.file_share.name},password=${azurerm_storage_account.file_share.primary_access_key},dir_mode=0777,file_mode=0777
      
  #     EOT
  # )

}

# mout fileShare && install xamp - apache
resource "azurerm_virtual_machine_extension" "example" {
  name                 = "hostname"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm-a.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

settings = <<SETTINGS
 {
  "commandToExecute": "sudo mkdir -p /mnt/sharedfiles && sudo mount -t cifs //${azurerm_storage_account.account_share.name}.file.core.windows.net/${azurerm_storage_share.file_share.name} /mnt/sharedfiles -o vers=3.0,username=${azurerm_storage_account.account_share.name},password=${azurerm_storage_account.account_share.primary_access_key},dir_mode=0777,file_mode=0777 && chmod +x /mnt/sharedfiles/xampp-linux-x64-8.0.30-0-installer.run && sudo /mnt/sharedfiles/xampp-linux-x64-8.0.30-0-installer.run && sudo /opt/lampp/lampp start && sudo /opt/lampp/lampp startapache"

  }
SETTINGS
depends_on = [ null_resource.upload_file ]
}


resource "azurerm_linux_virtual_machine" "linux_vm-b" {
  name                = var.azurerm_linux_virtual_machine_name-2
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  location            = azurerm_resource_group.terraform_Lab.location
  size                = var.azurerm_windows_virtual_machine_size
  admin_username      = var.azurerm_linux_virtual_machine_userName-2
  network_interface_ids = [
    azurerm_network_interface.linux_VM_2_nic.id,
  ]
  zone = "2"
  depends_on = [ azurerm_subnet.hub_file-share_subnet ]

  admin_ssh_key {
    username   = var.azurerm_linux_virtual_machine_userName-2
    public_key = file("C:/Users/Compurter Store/123.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.azurerm_linux_virtual_machine_publisher
    offer     = var.azurerm_linux_virtual_machine_offer
    sku       = var.azurerm_linux_virtual_machine_SKU
    version   = var.azurerm_linux_virtual_machine_version
  }
  
}
# installing xamp && make directoty to file share
resource "azurerm_virtual_machine_extension" "installation" {
  name                 = "installation"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm-b.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "commandToExecute": "sudo mkdir -p /mnt/sharedfiles && sudo mount -t cifs //${azurerm_storage_account.account_share.name}.file.core.windows.net/${azurerm_storage_share.file_share.name} /mnt/sharedfiles -o vers=3.0,username=${azurerm_storage_account.account_share.name},password=${azurerm_storage_account.account_share.primary_access_key},dir_mode=0777,file_mode=0777 && chmod +x /mnt/sharedfiles/xampp-linux-x64-8.0.30-0-installer.run && sudo /mnt/sharedfiles/xampp-linux-x64-8.0.30-0-installer.run && sudo /opt/lampp/lampp start && sudo /opt/lampp/lampp startapache"

  }
SETTINGS

depends_on = [ null_resource.upload_file ]
}