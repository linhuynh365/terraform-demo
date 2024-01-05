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

resource "azurerm_management_lock" "lock" {
  name       = var.lock_name
  lock_level = var.lock_level
  scope      = var.scope
  notes      = var.notes
}