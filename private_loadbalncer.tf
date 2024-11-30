resource "azurerm_lb" "private_lb" {
  name                = "private-lb"
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  sku                 = "Standard"


  frontend_ip_configuration {
    name                 = "private-lb-frontend"
    subnet_id            = azurerm_subnet.hub_file-share_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "private_backend_pool" {
  name                = "private_backend-pool"
  loadbalancer_id     = azurerm_lb.private_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "linux_VM_1_nic_association" {
  network_interface_id            = azurerm_network_interface.linux_VM_1_nic.id
  ip_configuration_name           = "internal1"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.private_backend_pool.id
    depends_on =[azurerm_network_interface.linux_VM_1_nic ]

}

resource "azurerm_network_interface_backend_address_pool_association" "linux_VM_2_nic_association" {
  network_interface_id            = azurerm_network_interface.linux_VM_2_nic.id
  ip_configuration_name           = "internal2"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.private_backend_pool.id
    depends_on =[azurerm_network_interface.linux_VM_2_nic]

}

resource "azurerm_lb_probe" "tcp_probe" {
  name                = "tcp-probe"
  loadbalancer_id     = azurerm_lb.private_lb.id
  protocol            = "Tcp"
  port                = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.private_lb.id
  protocol                       = "Tcp"
  frontend_ip_configuration_name = azurerm_lb.private_lb.frontend_ip_configuration[0].name
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.private_backend_pool.id]
  probe_id                       = azurerm_lb_probe.tcp_probe.id
}