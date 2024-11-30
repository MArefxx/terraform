
resource "azurerm_windows_virtual_machine" "windows-server-p" {
  name                = var.azurerm_windows_virtual_machine-1
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  location            = azurerm_resource_group.terraform_Lab.location
  size                = var.azurerm_windows_virtual_machine_size
  admin_username      = "medo"
  admin_password      = "Medo@ref.2024"
  
  network_interface_ids = [
    azurerm_network_interface.W_S_VM_1_nic.id
  ]
 depends_on = [ azurerm_subnet.hub_public_subnet ]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.azurerm_windows_virtual_machine_publisher
    offer     = var.azurerm_windows_virtual_machine_offer
    sku       = var.azurerm_windows_virtual_machine_SKU
    version   = var.azurerm_windows_virtual_machine_version
  }

  
}
resource "azurerm_virtual_machine_extension" "install_IIS1_features" {
  name                 = "InstallFeatures"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-server-p.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
  {
    "commandToExecute": "powershell.exe Add-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing,Web-Http-Errors, Web-Static-Content, Web-Http-Redirect, Web-Health, Web-Http-Logging, Web-Http-Tracing,Web-Performance, Web-Stat-Compression, Web-Security, Web-Filtering, Web-Basic-Auth, Web-IP-Security,Web-Url-Auth, Web-Windows-Auth, Web-App-Dev, Web-Net-Ext45, Web-ASP, Web-Asp-Net45, Web-CGI, Web-ISAPI-Ext,Web-ISAPI-Filter, Web-WebSockets, Web-Ftp-Server, Web-Ftp-Service, Web-Mgmt-Tools, Web-Mgmt-Console, Web-Scripting-Tools"
  }
  SETTINGS
}

resource "azurerm_windows_virtual_machine" "windows-server-b" {
  name                = var.azurerm_windows_virtual_machine-2
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  location            = azurerm_resource_group.terraform_Lab.location
  size                = var.azurerm_windows_virtual_machine_size
  admin_username      = var.azurerm_windows_virtual_machine_admin_username
  admin_password      = var.azurerm_windows_virtual_machine_admin_pasworrd
  network_interface_ids = [
    azurerm_network_interface.W_S_VM_2_nic.id
  ]
  zone = "2"
 depends_on = [ azurerm_subnet.hub_public_subnet ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.azurerm_windows_virtual_machine_publisher
    offer     = var.azurerm_windows_virtual_machine_offer
    sku       = var.azurerm_windows_virtual_machine_SKU
    version   = var.azurerm_windows_virtual_machine_version
  }
}
resource "azurerm_virtual_machine_extension" "install_IIS2_features" {
  name                 = "InstallFeatures"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-server-b.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
  {
    "commandToExecute": "powershell.exe Add-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-Default-Doc, Web-Dir-Browsing,Web-Http-Errors, Web-Static-Content, Web-Http-Redirect, Web-Health, Web-Http-Logging, Web-Http-Tracing,Web-Performance, Web-Stat-Compression, Web-Security, Web-Filtering, Web-Basic-Auth, Web-IP-Security,Web-Url-Auth, Web-Windows-Auth, Web-App-Dev, Web-Net-Ext45, Web-ASP, Web-Asp-Net45, Web-CGI, Web-ISAPI-Ext,Web-ISAPI-Filter, Web-WebSockets, Web-Ftp-Server, Web-Ftp-Service, Web-Mgmt-Tools, Web-Mgmt-Console, Web-Scripting-Tools"
  }
  SETTINGS
}