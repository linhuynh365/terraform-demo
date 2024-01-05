#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.id
}

output "name" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.name
}

output "location" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.location
}

output "fqdn" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.fqdn
}

output "ingress_application_gateway" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.ingress_application_gateway
}

output "oidc_issuer_enabled" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.oidc_issuer_enabled
}

output "oidc_issuer_url" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.oidc_issuer_url
}

output "service_principal" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.service_principal
}

output "tags" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.tags
}

output "identity" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.identity
}

output "kubelet_identity" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.kubelet_identity
}

output "key_vault_secrets_provider" {
  value = data.azurerm_kubernetes_cluster.aks_data_source.key_vault_secrets_provider
}
