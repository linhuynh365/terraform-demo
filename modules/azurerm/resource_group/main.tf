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

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = merge(var.tags, { "created_by" = "dep_terraform", "type" = "resource_group" })

}
