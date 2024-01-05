#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_public_ip.public_ip.id
}

output "name" {
  value = azurerm_public_ip.public_ip.name
}

output "tags" {
  value = azurerm_public_ip.public_ip.tags
}

output "ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "domain_name_label" {
  value = azurerm_public_ip.public_ip.domain_name_label
}

output "fqdn" {
  value = azurerm_public_ip.public_ip.fqdn
}

