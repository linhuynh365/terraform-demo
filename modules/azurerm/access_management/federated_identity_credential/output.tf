#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_federated_identity_credential.federated_identity_credential.id
}

output "name" {
  value = azurerm_federated_identity_credential.federated_identity_credential.name
}

output "resource_group_name" {
  value = azurerm_federated_identity_credential.federated_identity_credential.resource_group_name
}

output "audience" {
  value = azurerm_federated_identity_credential.federated_identity_credential.audience
}

output "issuer" {
  value = azurerm_federated_identity_credential.federated_identity_credential.issuer
}

output "parent_id" {
  value = azurerm_federated_identity_credential.federated_identity_credential.parent_id
}

output "subject" {
  value = azurerm_federated_identity_credential.federated_identity_credential.subject
}
