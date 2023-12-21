#############################################################################
# REQUIRED PROVIDER
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.50.0"
#     }
#   }
#   required_version = "1.4.6"
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_storage_account" "sa" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  enable_https_traffic_only     = var.enable_https_traffic_only
  public_network_access_enabled = var.public_network_access_enabled
  network_rules {
    default_action = var.network_rules_default_action
    bypass         = var.network_rules_bypass
    ip_rules       = var.network_rules_ip_rules
  }
  tags = merge(var.tags, { "created_by" = "dep_terraform", "type" = "storage_account", "DatadogLogs" = "true", "DatadogMetrics" = "true" })
}
