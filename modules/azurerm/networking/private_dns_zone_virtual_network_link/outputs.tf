#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.id
}

output "name" {
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.name
}

output "tags" {
  value = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.tags
}

# output "private_dns_zone_virtual_network_link" {
#   value = {
#     name                        = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.name
#     id                          = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.id
#     tags                        = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.tags
#   }
#   description = "All information about private dns zone virtual network link."
# }
