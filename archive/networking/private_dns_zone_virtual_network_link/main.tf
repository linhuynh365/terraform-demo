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

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = var.name
  private_dns_zone_name = var.private_dns_zone_name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
  # tags                  = merge(var.tags, { "created_by" = "dep_terraform", "type" = "private_dns_zone_virtual_network_link" })
}
