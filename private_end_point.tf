resource "azurerm_private_endpoint" "private_end_point" {
  name                = "private-endpoint"
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  subnet_id           = azurerm_subnet.End_point_public_subnet.id

  private_service_connection {
    name                           = "sql-private-connection"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns.id]
  }
  
}