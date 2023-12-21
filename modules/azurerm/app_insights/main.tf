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

resource "azurerm_application_insights" "app_insights" {

  name                                  = var.name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  workspace_id                          = var.workspace_id
  application_type                      = var.application_type
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notification_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  disable_ip_masking                    = var.disable_ip_masking
  tags                                  = merge(var.tags, { "created_by" = "dep_terraform", "type" = "app_insights" })
}