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

resource "azurerm_traffic_manager_azure_endpoint" "traffic_manager_azure_endpoint" {
  name               = var.name
  profile_id         = var.profile_id
  target_resource_id = var.target_resource_id
}
