#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value       = azurerm_private_dns_zone.private_dns_zone.id
}

output "name" {
  value       = azurerm_private_dns_zone.private_dns_zone.name
}

output "tags" {
  value       = azurerm_private_dns_zone.private_dns_zone.tags
}

# output "private_dns_zone" {
#   value = {
#     name                        = azurerm_private_dns_zone.private_dns_zone.name
#     id                          = azurerm_private_dns_zone.private_dns_zone.id
#     tags                        = azurerm_private_dns_zone.private_dns_zone.tags
#   }
#   description = "All information about private dns zone."
# }
