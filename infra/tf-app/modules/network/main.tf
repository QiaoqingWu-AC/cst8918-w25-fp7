resource "azurerm_virtual_network" "vnet" {
  name = "group7-vnet"
  location = var.location
  address_space = [ "10.0.0.0/14" ]
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  for_each = {
    prod = "10.0.0.0/16"
    test = "10.1.0.0/16"
    dev = "10.2.0.0/16"
    admin = "10.3.0.0/16"
  }

  name = each.key
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [ each.value ]
}