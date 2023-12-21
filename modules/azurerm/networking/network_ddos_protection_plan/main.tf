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

resource "azurerm_network_ddos_protection_plan" "network_ddos_protection_plan" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.name
  tags                = merge(var.tags, { "created_by" = "dep_terraform", "type" = "network_ddos_protection_plan" })
}
