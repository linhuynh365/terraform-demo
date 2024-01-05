#############################################################################
# REQUIRED PROVIDER
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source = "hashicorp/azurerm"
#     }
#   }
#   required_version = ">= 0.14.9"
# }


# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_log_analytics_workspace" "log_analytics_ws" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  retention_in_days   = var.retention_in_days
  tags                = merge(var.tags, { "created_by" = "dep_terraform", "type" = "log_analytics_workspace" })
}
