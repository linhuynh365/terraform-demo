#############################################################################
# REQUIRED PROVIDER
#############################################################################

#  terraform {
#    required_providers {
#      azurerm = {
#        source  = "hashicorp/azurerm"
#      }
#    }
#    required_version = ">= 0.14.9"
#  }


# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.traffic_routing_method
  tags                   = merge(var.tags, { "created_by" = "dep_terraform", "type" = "traffic_manager" })

  dns_config {
    relative_name = var.relative_name
    ttl           = var.ttl
  }

  monitor_config {
    protocol = var.protocol
    port     = var.port
    path     = var.path
  }
}
