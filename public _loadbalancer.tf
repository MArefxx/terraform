# Load Balancer
resource "azurerm_lb" "Public_lb" {
  name                = "public-lb"
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  sku                 = "Standard"
  timeouts {
    delete = "30m"
  }
  frontend_ip_configuration {
    name                 = "example-lb"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id

  }
}

# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.terraform_Lab.location
  resource_group_name = azurerm_resource_group.terraform_Lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
  timeouts {
    delete = "30m"
  }
}

# Load Balancer Backend Pool
resource "azurerm_lb_backend_address_pool" "public_backend_pool" {
  loadbalancer_id = azurerm_lb.Public_lb.id
  name            = "public-backend-pool"
}
# Load Balancer Health Probe
resource "azurerm_lb_probe" "public_health_probe" {
  loadbalancer_id = azurerm_lb.Public_lb.id
  name            = "example-probe"
  protocol        = "Tcp"
  port            = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancer Rule
resource "azurerm_lb_rule" "public_lb_rule" {
  loadbalancer_id            = azurerm_lb.Public_lb.id
  name                       = "example-lb-rule"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = "example-lb"
  backend_address_pool_ids    = [azurerm_lb_backend_address_pool.public_backend_pool.id]
  probe_id                   = azurerm_lb_probe.public_health_probe.id
}



# Attach Windows Srever VM-1 NIC to Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "w_s_1_association_1" {
  network_interface_id    = azurerm_network_interface.W_S_VM_1_nic.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.public_backend_pool.id
  ip_configuration_name   = "ipgonfig1"
  depends_on =[azurerm_network_interface.W_S_VM_1_nic]
}
# Attach Windows Server VM-2 to Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "w_s_2_association_1" {
  network_interface_id    = azurerm_network_interface.W_S_VM_2_nic.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.public_backend_pool.id
  ip_configuration_name   = "ipgonfig2"
  depends_on =[azurerm_network_interface.W_S_VM_2_nic]
}