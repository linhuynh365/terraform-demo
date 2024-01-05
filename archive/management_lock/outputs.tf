#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_management_lock.lock.id
}

output "name" {
  value = azurerm_management_lock.lock.name
}

output "scope" {
  value = azurerm_management_lock.lock.scope
}