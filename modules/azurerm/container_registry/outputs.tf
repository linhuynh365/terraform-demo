#############################################################################
# OUTPUTS
#############################################################################

output "name" {
  value = azurerm_container_registry.acr.name
}

output "id" {
  value = azurerm_container_registry.acr.id
}

output "tags" {
  value = azurerm_container_registry.acr.tags
}

output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.acr.login_server
}

# output "container_registry" {
#   value = {
#     name                        = azurerm_container_registry.acr.name
#     id                          = azurerm_container_registry.acr.id
#     tags                        = azurerm_container_registry.acr.tags
#     login_server                = azurerm_container_registry.acr.login_server
#   }
#   description = "All information about container registry."
# }