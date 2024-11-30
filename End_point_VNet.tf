resource "azurerm_virtual_network" "spoke_vnet" {
  name                = var.azurerm_End_point_virtual_network
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  address_space       = [var.azurerm_End_point_adrress_space]

}

resource "azurerm_subnet" "End_point_public_subnet" {
  name                 = var.azurerm_End_point_public_subnet_name
  resource_group_name  = azurerm_resource_group.terraform_Lab.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = [var.azurerm_End_point_public_subnet_address]

  #enforce_private_link_service_network_policies = true

  
}
