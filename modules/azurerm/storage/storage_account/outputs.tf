#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_storage_account.sa.id
}

output "name" {
  value = azurerm_storage_account.sa.name
}

output "tags" {
  value = azurerm_storage_account.sa.tags
}

output "location" {
  value = azurerm_storage_account.sa.location
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.sa.primary_blob_endpoint
}

output "primary_dfs_endpoint" {
  value = azurerm_storage_account.sa.primary_dfs_endpoint
}

output "primary_file_endpoint" {
  value = azurerm_storage_account.sa.primary_file_endpoint
}

output "primary_queue_endpoint" {
  value = azurerm_storage_account.sa.primary_queue_endpoint
}

output "primary_table_endpoint" {
  value = azurerm_storage_account.sa.primary_table_endpoint
}

# output "storage_account" {
#   value = {
#     name                        = azurerm_storage_account.sa.name
#     id                          = azurerm_storage_account.sa.id
#     tags                        = azurerm_storage_account.sa.tags
#     location                    = azurerm_storage_account.sa.location
#     primary_blob_endpoint       = azurerm_storage_account.sa.primary_blob_endpoint
#     primary_dfs_endpoint        = azurerm_storage_account.sa.primary_dfs_endpoint
#     primary_file_endpoint       = azurerm_storage_account.sa.primary_file_endpoint
#     primary_queue_endpoint      = azurerm_storage_account.sa.primary_queue_endpoint
#     primary_table_endpoint      = azurerm_storage_account.sa.primary_table_endpoint
#   }
#   description = "All information about storage account."
# }