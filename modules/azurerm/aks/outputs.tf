output "name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "tags" {
  value = azurerm_kubernetes_cluster.aks_cluster.tags
}

output "kubelet_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity.0.object_id
}

# output "kube_config_raw" {
#   value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
#   sensitive   = true
# }

output "private_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

# output "aks" {
#   value = {
#     name                        = azurerm_kubernetes_cluster.aks_cluster.name
#     id                          = azurerm_kubernetes_cluster.aks_cluster.id
#     tags                        = azurerm_kubernetes_cluster.aks_cluster.tags
#     kube_config_raw             = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw # how to make this sensitive
#     kubelet_identity_object_id  = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity.0.object_id
#     private_fqdn                = azurerm_kubernetes_cluster.aks_cluster.private_fqdn
#     node_resource_group         = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
#   }
#   description = "All information about AKS cluster."
# }
