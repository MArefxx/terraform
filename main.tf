terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.10.0"
    }
  }
}
 
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
resource "azurerm_resource_group" "terraform_Lab" {
  name     = "Terraform-RG"
  location = var.resource_group_location
}
 
 