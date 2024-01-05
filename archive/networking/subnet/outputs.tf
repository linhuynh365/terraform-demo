#############################################################################
# OUTPUTS
#############################################################################

output "id" {
  value = azurerm_subnet.subnet.id
}

output "name" {
  value = azurerm_subnet.subnet.name
}

output "virtual_network_name" {
  value = azurerm_subnet.subnet.virtual_network_name
}

output "address_prefixes" {
  value = azurerm_subnet.subnet.address_prefixes
}

# output "subnet" {
#   value = {
#     name                        = azurerm_subnet.subnet.name
#     id                          = azurerm_subnet.subnet.id
#     virtual_network_name        = azurerm_subnet.subnet.virtual_network_name
#   }
#   description = "All information about subnet."
# }
