#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.id
}

output "fqdn" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.fqdn
}

output "name" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.name
}

output "tags" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.tags
}

output "traffic_routing_method" {
  value = azurerm_traffic_manager_profile.traffic_manager_profile.traffic_routing_method
}
