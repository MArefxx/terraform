# Network Security Group
resource "azurerm_network_security_group" "windows-server-p_nsg" {
  name                = "myNSG"
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
   name                        = "allow-http"
   priority                    = 101
   direction                   = "Inbound"
   access                      = "Allow"
   protocol                    = "Tcp"
   source_port_range           = "*"
   destination_port_range      = "80"
   source_address_prefix       = "*"
   destination_address_prefix  = "*"
  }
  
   depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "W_nic1_association" {
  network_interface_id         = azurerm_network_interface.W_S_VM_1_nic.id
  network_security_group_id    = azurerm_network_security_group.windows-server-p_nsg.id
  depends_on = [ azurerm_network_interface.linux_VM_1_nic ]
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "W_nic2_association" {
  network_interface_id         = azurerm_network_interface.W_S_VM_2_nic.id
  network_security_group_id    = azurerm_network_security_group.windows-server-p_nsg.id
  depends_on = [ azurerm_network_interface.linux_VM_2_nic ]
}
# Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "subnet1_association" {
  subnet_id                 = azurerm_subnet.hub_public_subnet.id
  network_security_group_id = azurerm_network_security_group.windows-server-p_nsg.id
}