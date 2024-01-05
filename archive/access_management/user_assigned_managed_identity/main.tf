
# ############################################################################
# #REQUIRED PROVIDER
# ############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.50.0"
#     }
#   }
#   required_version = ">= 0.14.9"
# }

# provider "azurerm" {
#   features {}
# }

resource "azurerm_user_assigned_identity" "user_assigned_managed_identity" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, { "created_by" = "dep_terraform", "type" = "mi" })
}
