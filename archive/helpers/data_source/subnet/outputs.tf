#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = data.azurerm_subnet.subnet_data_source.id
}

output "address_prefixes" {
  value = data.azurerm_subnet.subnet_data_source.address_prefixes
}

output "network_security_group_id" {
  value = data.azurerm_subnet.subnet_data_source.network_security_group_id
}

output "route_table_id" {
  value = data.azurerm_subnet.subnet_data_source.route_table_id
}

output "service_endpoints" {
  value = data.azurerm_subnet.subnet_data_source.service_endpoints
}

output "private_endpoint_network_policies_enabled" {
  value = data.azurerm_subnet.subnet_data_source.private_endpoint_network_policies_enabled
}

output "private_link_service_network_policies_enabled" {
  value = data.azurerm_subnet.subnet_data_source.private_link_service_network_policies_enabled
}
