#Virtual network variables (required)
vnet_name          = "Vnet1"
vnet_location      = "Northeurope"
vnet_address_space = "10.0.0.0/16"
#(Optional)

#Subnet variables
subnet_name           = "sub1"
subnet_address_prefix = "10.0.1.0/24"

#Network Interface Variables
NIC_location = "Northeurope"
#Ipconfig
ip_name    = "Vm1-Public"
private_ip = "Dynamic"

#Virtual machine variables
vm_name           = "Vm1"
vm_location       = "Northeurope"
vm_size           = "Standard_B1s"
vm_admin_username = "AdminUser"
#Disk
disk_caching      = "ReadWrite"
disk_storage_type = "Standard_LRS"
#Source Image Referece
image_offer       = "WindowsServer"
sku               = "2022-Datacenter"

#Storage account Variables
storage_name     = "mike12345678"
storage_location = "Northeurope"
account_tier     = "Standard"
replication_type = "GRS"
tls              = "TLS1_2"
access_tier      = "Hot"

#Container variables
container_name   = "datamain"
container_access = "blob"

#Public Ip variables
ip_location    = "Northeurope"
allocation     = "Dynamic"
ip_sku         = "Basic"

#NSG variables
nsg_location = "Northeurope"

#Global variables
rg_name = "Project"
subscription_id = "06b189df-5788-49e9-a904-9bd0182fab09"
