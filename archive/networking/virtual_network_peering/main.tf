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
#   required_version = "1.4.5"
# }

#############################################################################
# RESOURCES
#############################################################################

# resource "azurerm_virtual_network_peering" "first-to-second" {
#   name                         = "first-to-second"
#   resource_group_name          = azurerm_resource_group.example.name
#   virtual_network_name         = azurerm_virtual_network.first.name
#   remote_virtual_network_id    = azurerm_virtual_network.second.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = false
#   allow_gateway_transit        = false
# }

# resource "azurerm_virtual_network_peering" "second-to-first" {
#   name                         = "second-to-first"
#   resource_group_name          = azurerm_resource_group.example.name
#   virtual_network_name         = azurerm_virtual_network.second.name
#   remote_virtual_network_id    = azurerm_virtual_network.first.id
#   allow_virtual_network_access = true
#   allow_forwarded_traffic      = false
#   allow_gateway_transit        = false
#   use_remote_gateways          = false
# }
