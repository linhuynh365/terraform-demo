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

resource "azurerm_federated_identity_credential" "federated_identity_credential" {
  name                = var.name
  resource_group_name = var.resource_group_name
  audience            = var.audience
  issuer              = var.issuer
  parent_id           = var.parent_id
  subject             = var.subject
}
