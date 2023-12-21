#############################################################################
# OUTPUTS
#############################################################################

output "name" {
  value       = azurerm_key_vault.keyvault.name
}

output "id" {
  value       = azurerm_key_vault.keyvault.id
}

output "tags" {
  value       = azurerm_key_vault.keyvault.tags
}

output "vault_uri" {
  value       = azurerm_key_vault.keyvault.vault_uri
}

# output "keyvault" {
#   value = {
#     name                        = azurerm_key_vault.keyvault.name
#     id                          = azurerm_key_vault.keyvault.id
#     tags                        = azurerm_key_vault.keyvault.tags
#     vault_uri                   = azurerm_key_vault.keyvault.vault_uri
#   }
#   description = "All information about keyvault."
# }