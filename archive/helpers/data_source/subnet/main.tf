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

data "azurerm_subnet" "subnet_data_source" {
  name                 = var.name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}
