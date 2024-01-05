#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_log_analytics_workspace.log_analytics_ws.id
}

output "name" {
  value = azurerm_log_analytics_workspace.log_analytics_ws.name
}

output "tags" {
  value = azurerm_log_analytics_workspace.log_analytics_ws.tags
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics_ws.workspace_id
}
