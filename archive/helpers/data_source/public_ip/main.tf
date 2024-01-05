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

# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

data "azurerm_public_ip" "public_ip_data_source" {
  name                = var.name
  resource_group_name = var.resource_group_name
}
