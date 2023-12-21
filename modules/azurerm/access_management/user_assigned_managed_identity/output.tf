output "name" {
  value = azurerm_user_assigned_identity.user_assigned_managed_identity.name
}

output "principal_id" {
  value = azurerm_user_assigned_identity.user_assigned_managed_identity.principal_id
}

output "id" {
  value = azurerm_user_assigned_identity.user_assigned_managed_identity.id
}

output "tags" {
  value = azurerm_user_assigned_identity.user_assigned_managed_identity.tags
}
