
# Private DNS Zone
resource "azurerm_private_dns_zone" "private_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.terraform_Lab.name
}

# Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "PrivateDNSLink"
  resource_group_name   = azurerm_resource_group.terraform_Lab.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.hub_vnet.id
}
# DNS Record for the SQL Server
resource "azurerm_private_dns_a_record" "dns_sql_record" {
  name                = azurerm_mssql_server.sql_server.name
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  zone_name           = azurerm_private_dns_zone.private_dns.name
  ttl                 = 300
  
  records = [
    azurerm_private_endpoint.private_end_point.private_service_connection[0].private_ip_address
  ]
}