#Provider - The provider I want to use this deployment with
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
}

provider "azurerm" {
    subscription_id = var.subscription_id
    features {}
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  resource_group_name = var.rg_name
  location = var.vnet_location
  address_space = [var.vnet_address_space]
}

resource "azurerm_subnet" "sub" {
  name = var.subnet_name
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = [var.subnet_address_prefix]
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each = var.vm_map

  name                = each.value.name
  resource_group_name = var.rg_name
  location            = var.vm_location
  size                = each.value.size
  admin_username      = var.vm_admin_username
  admin_password      = each.value.admin_password  # Must meet Azure complexity requirements
  priority            = each.value.priority
  eviction_policy     = each.value.eviction_policy
  max_bid_price       = each.value.max_bid_price

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = var.disk_caching
    storage_account_type = var.disk_storage_type
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = var.image_offer
    sku       = var.sku
    version   = "latest"
  }
}

resource "azurerm_network_interface" "nic" {
  for_each = var.vm_map

  name                = "${each.value.name}-nic"
  location            = var.NIC_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${each.value.name}-PublicIP"
    subnet_id                     = azurerm_subnet.sub.id 
    private_ip_address_allocation = var.private_ip
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[each.key].id
  }
}

resource "azurerm_public_ip" "vm_public_ip" {
for_each = var.vm_map

  name                = "${each.value.name}-public-ip"
  location            = var.ip_location
  resource_group_name = var.rg_name
  allocation_method   = var.allocation
  sku                 = var.ip_sku
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg_map

  name = each.value.name
  location = var.nsg_location
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content { 
      name = security_rule.value.name
      priority =  security_rule.value.priority
      direction =  security_rule.value.direction
      access =  security_rule.value.access
      protocol =  security_rule.value.protocol
      source_port_range =  security_rule.value.source_port_range
      destination_port_range =  security_rule.value.destination_port_range
      source_address_prefix =  security_rule.value.source_address_prefix
      destination_address_prefix =  security_rule.value.destination_address_prefix
    }  
  }
}

resource "azurerm_network_interface_security_group_association" "nsg-asso" {
for_each = var.nsg_map

  network_interface_id = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_storage_account" "store" {
  name = var.storage_name
  location = var.storage_location
  resource_group_name = var.rg_name
  account_tier = var.account_tier
  account_replication_type = var.replication_type
  min_tls_version = var.tls
  access_tier = var.access_tier
}

resource "azurerm_storage_container" "test" {
  name = var.container_name
  container_access_type = var.container_access
  storage_account_id = azurerm_storage_account.store.id  
}  

