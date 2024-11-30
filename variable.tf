variable "resource_group_name" {
    description = "name of the resource_group"
 
    default = " Terraform_RG"
  
}
variable "resource_group_location"{
    description = "location of the resource"
    type = string
    default = "North Europe"
}
variable "azurerm_hub_virtual_network" {
  description = "Hub_VNet_name"
  type = string
  default = "Hub_VNet"
}
variable "azurerm_End_point_virtual_network" {
  description = "End_point_VNet_name"
  type = string
  default = "spoke_VNet"
}
variable "azurerm_hub_adrress_space" {
    description = "Hub_VNet-address-space"
    type = string
    default = "10.0.0.0/16"
}
variable "azurerm_End_point_adrress_space" {
    description = "spoke_VNet-address-space"
    type = string
    default = "10.1.0.0/16"
}
variable "azurerm_hub_public_subnet_name" {
    description = "The subnet name for the Azure public subnet in the hub network"
    type = string
    default = "Subnet1"
  
}
variable "azurerm_End_point_public_subnet_name" {
    description = "The subnet name for the Azure public subnet in the End_point network"
    type = string
    default = "private-DB-Snet"
  
}
variable "azurerm_hub_public_subnet_address" {
    description = "The subnet address for the Azure public subnet in the hub network"
    type = string
    default = "10.0.2.0/24"
  
}
variable "azurerm_End_point_public_subnet_address" {
    description = "The subnet address for the Azure public subnet in the End_point network"
    type = string
    default = "10.1.2.0/24"
  
}
variable "azurerm_hub_file-share_subnet_name" {
    description = "The subnet name for the Azure file share in the hub network"
    type = string
    default = "subent2"
  
}
variable "azurerm_hub_file-share_subnet_address" {
    description = "The subnet address for the Azure file share in the hub network"
    type = string
    default = "10.0.3.0/24"
  
}
variable "azurerm_windows_virtual_machine-1_interface_card-name" {
description = "the name of the interface card for the first windows server virtual machine"
  type = string
  default = "nic_W_S_VM_1"
}
variable "azurerm_windows_virtual_machine-2_interface_card-name" {
description = "the name of the interface card for the scound windows server virtual machine"
  type = string
  default = "nic_W_S_VM_2"
}
variable "azurerm_windows_virtual_machine-1" {
    description = "the name of the first windows server virtual machine "
    type = string
    default = "VM01"
  
}
variable "azurerm_windows_virtual_machine-2" {
    description = "the name of the first windows server virtual machine "
    type = string
    default = "VM02"
  
}

variable "azurerm_windows_virtual_machine_VM01_size" {
  description = "the size of the VM01 "
  type = string
  default = "Standard_D16as_v4"
}
variable "azurerm_windows_virtual_machine_size" {
    description = "the size of the  virtual machine"
    type = string
    default = "Standard_DS1_v2"
  
}
variable "azurerm_windows_virtual_machine_admin_username" {
    description = "the admin username of the windows server virtual machine"
    type = string
    default = "Medo"
  
}
variable "azurerm_windows_virtual_machine_admin_pasworrd" {
    description = "the admin passworrd of the windows server virtual machine"
    type = string
    default = "Medo1234"
  
}
variable "azurerm_windows_virtual_machine_publisher" {
    description = " source_image_referencee publisher"
    type = string
  default = "MicrosoftWindowsServer"
}
variable "azurerm_windows_virtual_machine_offer" {
  description = "source_image_referencee offer "
  type = string
  default = "WindowsServer"
}
variable "azurerm_windows_virtual_machine_SKU" {
  description = "source_image_referencee SKU "
  type = string
  default = "2016-Datacenter"
}
variable "azurerm_windows_virtual_machine_version" {
  description = "source_image_referencee version "
  type = string
  default = "latest"
}
variable "azurerm_linux_virtual_machine_name-1" {
  description = "this the name of the first linux virtual machine "
  type = string
  default = "VM03"  
}
variable "azurerm_linux_virtual_machine_name-2" {
  description = "this the name of the scound linux virtual machine "
  type = string
  default = "VMO4"  
}
variable "azurerm_linux_virtual_machine_userName-1" {
  description = "the name of the admin userName for the first linux virtual machine "
  type = string
  default = "Medo"
}
variable "azurerm_linux_virtual_machine_userName-2" {
  description = "the name of the admin userName for the scound linux virtual machine "
  type = string
  default = "Aref"
}

#Standard_DS1_v2
variable "azurerm_linux_virtual_machine_size-1" {
  description = "the size of the linux virtual machine"
  type = string
  default = "Standard_B1s"
}
variable "azurerm_linux_virtual_machine_publisher" {
    description = " source_image_referencee publisher"
    type = string
  default = "Canonical"
}
variable "azurerm_linux_virtual_machine_offer" {
  description = "source_image_referencee offer "
  type = string
  default = "0001-com-ubuntu-server-jammy"
}
variable "azurerm_linux_virtual_machine_SKU" {
  description = "source_image_referencee SKU "
  type = string
  default = "22_04-lts"
}
variable "azurerm_linux_virtual_machine_version" {
  description = "source_image_referencee version "
  type = string
  default = "latest"
}

variable "vm_admin_ssh_public_key_path" {
  type        = string
  default     = "/.ssh/id_rsa.pub"  # Path to your SSH public key
}
variable "azurerm_linux_virtual_machine-1_interface_card-name" {
description = "the name of the interface card for the first windows server virtual machine"
  type = string
  default = "nic_L_VM_1"
}
variable "azurerm_linux_virtual_machine-2_interface_card-name" {
description = "the name of the interface card for the first windows server virtual machine"
  type = string
  default = "nic_L_VM_2"
}


