#############################################################################
# OUTPUTS
#############################################################################

output "resource_group" {
  value = {
    id       = module.resource_group.id
    name     = module.resource_group.name
    location = module.resource_group.location
  }
  description = "The information on all resource groups."
}

# Network outputs
output "virtual_network" {
  value = {
    id            = module.virtual_network.id
    name          = module.virtual_network.name
    location      = module.virtual_network.location
    address_space = module.virtual_network.address_space
  }
  description = "The information on all virtual networks."
}
