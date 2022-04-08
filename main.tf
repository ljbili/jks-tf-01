provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tf-01"
    storage_account_name = "tfbe01"
    container_name       = "lok"
    key                  = "terraform77.tfstate"
  }
}

provider "azuread" {
  client_id     = "id-terraformtest"
  client_secret = "eW9yDKZL~_rERWVdqB7p1Q1~hB8oLi02aj"
  tenant_id     = "58357bf7-2207-40ed-ab8d-f21fcf2a1035"
}



###################cntivité

# Step 1 : Create the resource group
resource "azurerm_resource_group" "rg_cnt" {
  name                = var.rg_cnt
  location            = var.location
  tags                = var.tags
}

# Step 2 : Create Virtual Network
resource "azurerm_virtual_network" "vnethub" {
  name                = "vnetcnt"
  resource_group_name = azurerm_resource_group.rg_cnt.name
  location            = var.location
  address_space       = var.vnet_address_space_cnt
  tags                = var.tags
}
#Step 3 : Create Subnets "GatewaySubnet" & "AzureFirewallSubnet"
resource "azurerm_subnet" "subgtw" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg_cnt.name
  virtual_network_name = azurerm_virtual_network.vnethub.name
  address_prefixes     = var.address_prefixes_gateway_cnt
}

## Step 4 : Network Watcher
#resource "azurerm_network_watcher" "netwatchname_cnt" {
#  name                = var.networkwatcher_cnt
#  location            = var.location
#  resource_group_name = azurerm_resource_group.rg_cnt.name
#}


###################Identité

# Step 1 : Create the resource group
resource "azurerm_resource_group" "rg_idt" {
  name                = var.rg_idt
  location            = var.location
  tags                = var.tags
}

# Step 2 : Create Virtual Network 

resource "azurerm_virtual_network" "vnetidt" {
  name                = var.vnet_name_idt
  resource_group_name = azurerm_resource_group.rg_idt.name
  location            = var.location
  address_space       = var.address_spaces_idt
  tags                = var.tags
}

# Step 3 : Create Subnet
resource "azurerm_subnet" "subnetidt" {
  name                                           = var.subnet_names_idt
  resource_group_name                            = azurerm_resource_group.rg_idt.name
  address_prefixes                               = var.subnet_prefixes_idt
  virtual_network_name                           = azurerm_virtual_network.vnetidt.name
}

resource "azurerm_network_interface" "lnxint" {
  name                = "lninter-nic"
  resource_group_name = azurerm_resource_group.rg_idt.name
  location            = azurerm_resource_group.rg_idt.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetidt.id
    private_ip_address_allocation = "Dynamic"
  }
}
# create Linux VM
resource "azurerm_linux_virtual_machine" "lnx" {
  name                            = "linux-vm-identity"
  resource_group_name             = azurerm_resource_group.rg_idt.name
  location                        = azurerm_resource_group.rg_idt.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.lnxint.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  tags = {
    environment = "Preprod"
  }
}

#resource "azurerm_network_interface" "lnxint2" {
#  name                = "lninter-nic"
#  resource_group_name = azurerm_resource_group.rg_idt.name
#  location            = azurerm_resource_group.rg_idt.location
#
#  ip_configuration {
#    name                          = "internal"
#    subnet_id                     = azurerm_subnet.subnetidt.id
#    private_ip_address_allocation = "Dynamic"
#  }
#}

# create Linux VM2
#resource "azurerm_linux_virtual_machine" "lnx2" {
#  name                            = "linux-vm2"
#  resource_group_name             = azurerm_resource_group.rg_idt.name
#  location                        = azurerm_resource_group.rg_idt.location
#  size                            = "Standard_F2"
#  admin_username                  = "adminuser"
#  admin_password                  = "P@ssw0rd1234!"
#  disable_password_authentication = false
#  network_interface_ids = [
#    azurerm_network_interface.lnxint2.id,
#  ]
#
#  source_image_reference {
#    publisher = "Canonical"
#    offer     = "UbuntuServer"
#    sku       = "16.04-LTS"
#    version   = "latest"
#  }
#
#  os_disk {
#    storage_account_type = "Standard_LRS"
#    caching              = "ReadWrite"
#  }
#}


# Step 4 : Network Watcher
#resource "azurerm_network_watcher" "netwatchname_idt" {
#  name                = var.networkwatcher_idt
#  location            = var.location
#  resource_group_name = azurerm_resource_group.rg_idt.name
#}
