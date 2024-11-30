resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.azurerm_hub_virtual_network
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  address_space       = [var.azurerm_hub_adrress_space]
  timeouts {
    delete = "30m"
  }

}


resource "azurerm_subnet" "hub_public_subnet" {
  name                 = var.azurerm_hub_public_subnet_name
  resource_group_name  = azurerm_resource_group.terraform_Lab.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.azurerm_hub_public_subnet_address]
  
}


resource "azurerm_subnet" "hub_file-share_subnet" {
  name                 = var.azurerm_hub_file-share_subnet_name
  resource_group_name  = azurerm_resource_group.terraform_Lab.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = [var.azurerm_hub_file-share_subnet_address]
  
 
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip_VM01"
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  location            = azurerm_resource_group.terraform_Lab.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "W_S_VM_1_nic" {
  name                = var.azurerm_windows_virtual_machine-1_interface_card-name
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name

  ip_configuration {
    name                          = "ipgonfig1"
    subnet_id                     = azurerm_subnet.hub_public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface" "W_S_VM_2_nic" {
  name                = var.azurerm_windows_virtual_machine-2_interface_card-name
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  timeouts {
    delete = "30m"
  }
  ip_configuration {
    name                          = "ipgonfig2"
    subnet_id                     = azurerm_subnet.hub_file-share_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "linux_VM_1_nic" {
  name                = var.azurerm_linux_virtual_machine-1_interface_card-name
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.hub_file-share_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "linux_VM_2_nic" {
  name                = var.azurerm_linux_virtual_machine-2_interface_card-name
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name

  ip_configuration {
    name                          = "internal2"
    subnet_id                     = azurerm_subnet.hub_file-share_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

