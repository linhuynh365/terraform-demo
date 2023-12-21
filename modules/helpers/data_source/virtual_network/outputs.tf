#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = data.azurerm_virtual_network.vnet_data_source.id
}

output "location" {
  value = data.azurerm_virtual_network.vnet_data_source.location
}

output "address_space" {
  value = data.azurerm_virtual_network.vnet_data_source.address_space
}

output "dns_servers" {
  value = data.azurerm_virtual_network.vnet_data_source.dns_servers
}

output "guid" {
  value = data.azurerm_virtual_network.vnet_data_source.guid
}

output "subnets" {
  value = data.azurerm_virtual_network.vnet_data_source.subnets
}

output "vnet_peerings" {
  value = data.azurerm_virtual_network.vnet_data_source.vnet_peerings
}

output "vnet_peerings_addresses" {
  value = data.azurerm_virtual_network.vnet_data_source.vnet_peerings_addresses
}

output "tags" {
  value = data.azurerm_virtual_network.vnet_data_source.tags
}
