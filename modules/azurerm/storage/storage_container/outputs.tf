#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_storage_container.sc.id
}

output "name" {
  value = azurerm_storage_container.sc.name
}

output "resource_manager_id" {
  value = azurerm_storage_container.sc.resource_manager_id
}
