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

resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  name                 = var.name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
}
