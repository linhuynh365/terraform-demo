#############################################################################
# OUTPUTS
#############################################################################

output "name" {
  value       = azurerm_cosmosdb_account.cosmosdb_account.name
}

output "id" {
  value       = azurerm_cosmosdb_account.cosmosdb_account.id
}

output "tags" {
  value       = azurerm_cosmosdb_account.cosmosdb_account.tags
}

output "account_endpoint" {
  value       = azurerm_cosmosdb_account.cosmosdb_account.endpoint
}

output "cosmos_db" {
  value = {
    name                        = azurerm_cosmosdb_account.cosmosdb_account.name
    id                          = azurerm_cosmosdb_account.cosmosdb_account.id
    tags                        = azurerm_cosmosdb_account.cosmosdb_account.tags
    account_endpoint            = azurerm_cosmosdb_account.cosmosdb_account.endpoint
  }
  description = "All information about Cosmos DB."
}