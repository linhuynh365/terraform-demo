#############################################################################
# OUTPUTS
#############################################################################

output "name" {
  value       = azurerm_application_insights.app_insights.name
}

output "id" {
  value       = azurerm_application_insights.app_insights.id
}

output "tags" {
  value       = azurerm_application_insights.app_insights.tags
}

output "app_id" {
  value       = azurerm_application_insights.app_insights.app_id
}

# output "app_insight" {
#   value = {
#     name                        = azurerm_application_insights.app_insights.name
#     id                          = azurerm_application_insights.app_insights.id
#     tags                        = azurerm_application_insights.app_insights.tags
#     app_id                      = azurerm_application_insights.app_insights.app_id
#   }
#   description = "All information about app insight."
# }