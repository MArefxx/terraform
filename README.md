# terraform
Create a scenario by terraform
Use-Case Requirement:

 

Create this scenario by terraform
Create one resource group: Terraform-RG
Create two Vnets
Set up peering between the two VNets.
In the Hub Vnet , Create two Subnet:
One for two Windows servers
One for two Linux servers
Ensure each VM is placed in a different availability zone.
Note: Attach one Windows VM to a public IP.

Create two load balancers :
one public load balancer between two Windows server
one private load balancer between two Linux servers.
Note: In the load balancer, create a pool, rules, and health checks using Terraform.

 

Create storage account [Premium file share].
Create azure SQL DB.
In the other VNet, create a subnet for the private endpoint for Azure SQL Database.
Create a private DNS zone for the SQL Database and attach it to the private endpoint.
 

Install IIS server in two windows servers
[for outstanding performance]  try using Terraform to install IIS on the Windows servers. If this cannot be done, install it manually.
On one Windows server, display "Hello Website 1" when IIS is installed, and on the other, display "Hello Website 2".
 

Install Apache on the Two Linux Servers.
 

Mount file shared in two linux servers
Note: Ensure the mount is added to the fstab file for persistence.
 

Create a Virtual Network Link from the Private DNS Zone to the Hub VNet.
 
