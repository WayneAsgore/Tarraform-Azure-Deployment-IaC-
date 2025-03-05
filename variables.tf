#Virtual network variables
variable vnet_name {}
variable "vnet_location" {}
variable "vnet_address_space" {}
#Subnet variables
variable "subnet_name" {}
variable "subnet_address_prefix" {}
#Virtual machine variables
variable "vm_name" {}
variable "vm_location" {}
variable "vm_size" {}
variable "vm_admin_username" {}
variable "disk_caching" {}
variable "disk_storage_type" {}
variable "image_offer" {}
variable "sku" {}
#Network Interface variables
variable "NIC_location" {}
variable "ip_name" {}
variable "private_ip" {}
#Storage account variables
variable "storage_name" {}
variable "storage_location" {}
variable "account_tier" {}
variable "replication_type" {}
variable "tls" {}
variable "access_tier" {}
#Container variables
variable "container_name" {}
variable "container_access" {}
#Public Ip variables
variable ip_location {}
variable allocation {}
variable "ip_sku" {}
#NSG variables
variable "nsg_location" {}
#Global variables
variable "rg_name" {}
variable "subscription_id" {}

#Mapping
variable "vm_map" {
  type = map(object({
    name = string
    size = string
    admin_password = string
    priority = string
    eviction_policy = string
    max_bid_price = string
  }))
  default = {
    "vm1" = {
      name = "vm1"
      size = "Standard_DS1_v2"
      admin_password = "123456789aA!aedsadsa"
      priority = "Spot"
      eviction_policy = "Deallocate"
      max_bid_price = -1
    }
    "vm2" = {
      name = "vm2"
      size = "Standard_DS1_v2"
      admin_password = "123456789aA!grasffs"
      priority = "Spot"
      eviction_policy = "Deallocate"
      max_bid_price = -1
    }
    "vm3" = {
      name = "vm3"
      size = "Standard_DS1_v2"
      admin_password = "123456789gr$4gsaA!"
      priority = "Spot"
      eviction_policy = "Deallocate"
      max_bid_price = -1
    }  
  }
}

variable "nsg_map" {
  type = map(object({
    name = string
    rules = list(object({
      name = string
      priority = number
      direction = string
      access = string
      protocol = string
      source_port_range = string
      destination_port_range = number      
      source_address_prefix = string
      destination_address_prefix = string
  }))
  }))
  default = {
    "vm1" = {
      name = "vm1-nsg"
      rules = [
        {
        name = "Block_RDP"
        priority = 100
        direction = "Inbound"
        access = "Deny"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = 3389
        source_address_prefix = "Internet"
        destination_address_prefix = "*"
      }]}
    "vm2" = {
      name = "vm2-nsg"
      rules = [
        {
        name = "Block_RDP"
        priority = 100
        direction = "Inbound"
        access = "Deny"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = 3389
        source_address_prefix = "Internet"
        destination_address_prefix = "*"
      }]}
    "vm3" = {
      name = "vm3-nsg"
      rules = [
        {
        name = "Block_RDP"
        priority = 100
        direction = "Inbound"
        access = "Deny"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = 3389
        source_address_prefix = "Internet"
        destination_address_prefix = "*"
      }]    
    }
  }
}
