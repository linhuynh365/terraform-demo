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

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  # tags                = merge(var.tags, { "created_by" = "dep_terraform", "type" = "private_dns_zone" })
}