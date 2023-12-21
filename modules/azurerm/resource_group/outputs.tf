#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value       = azurerm_resource_group.rg.id
}

output "name" {
  value       = azurerm_resource_group.rg.name
}

output "tags" {
  value       = azurerm_resource_group.rg.tags
}

output "location" {
  value       = azurerm_resource_group.rg.location
}

# output "resource_group" {
#   value = {
#     name                        = azurerm_resource_group.rg.name
#     id                          = azurerm_resource_group.rg.id
#     tags                        = azurerm_resource_group.rg.tags
#     location                    = azurerm_resource_group.rg.location
#   }
#   description = "All information about resource group."
# }