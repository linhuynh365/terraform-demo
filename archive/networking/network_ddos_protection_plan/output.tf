#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.id
}

output "name" {
  value = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.name
}

output "tags" {
  value = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.tags
}

output "virtual_network_ids" {
  value = azurerm_network_ddos_protection_plan.network_ddos_protection_plan.virtual_network_ids
}
