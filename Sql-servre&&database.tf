# SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "aref-sql-server-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.terraform_Lab.name
  location                     = azurerm_resource_group.terraform_Lab.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "P@ssword123!"

  
}
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
# SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name                = "sql_database"
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = "S1"
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 10
  zone_redundant      = false
}