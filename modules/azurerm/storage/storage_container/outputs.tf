#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_storage_container.sc.id
}

output "name" {
  value = azurerm_storage_container.sc.name
}

# output "tags" {
#   value = azurerm_storage_container.sc.tags
# }

output "resource_manager_id" {
  value = azurerm_storage_container.sc.resource_manager_id
}

# output "storage_container" {
#   value = {
#     name                        = azurerm_storage_container.sc.name
#     id                          = azurerm_storage_container.sc.id
#     tags                        = azurerm_storage_container.sc.tags
#     resource_manager_id         = azurerm_storage_container.sc.resource_manager_id
#   }
#   description = "All information about storage container."
# }