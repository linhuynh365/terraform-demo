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

# data "azurerm_resource_group" "rg" {
#   name = var.resource_group_name
# }

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.name
  address_space       = var.address_space
  ddos_protection_plan {
    id     = var.ddos_protection_plan_id
    enable = true
}
  tags = merge(var.tags, { "created_by" = "dep_terraform", "type" = "virtual_network" })
}
