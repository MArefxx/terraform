# VNet Peering from Hub_VNet_to_spoke_VNet
resource "azurerm_virtual_network_peering" "Hub_VNet_to_spoke_VNet2" {
  name                      = "Hub_VNet_to_spoke_VNet"
  resource_group_name       = azurerm_resource_group.terraform_Lab.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
  depends_on = [ azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet ]

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# VNet Peering from spoke_VNet_to_Hub_VNet
resource "azurerm_virtual_network_peering" "spoke_VNet_to_Hub_VNet" {
  name                      = "spoke_VNet_to_Hub_VNet"
  resource_group_name       = azurerm_resource_group.terraform_Lab.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
depends_on = [ azurerm_virtual_network.hub_vnet, azurerm_virtual_network.spoke_vnet ]
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
