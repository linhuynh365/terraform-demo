#############################################################################
# REQUIRED PROVIDER
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">=3.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  # tags                = merge(var.tags, { "created_by" = "dep_terraform", "type" = "private_endpoint" })

  private_service_connection {
    name                           = var.private_connection_name
    private_connection_resource_id = var.private_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = [var.subresource_name]
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = var.private_dns_zone_ids
  }
}
