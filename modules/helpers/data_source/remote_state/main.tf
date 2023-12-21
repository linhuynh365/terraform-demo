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

data "terraform_remote_state" "tfstate" {
  backend = "azurerm"
  config = {
    tenant_id            = var.tenant_id
    subscription_id      = var.subscription_id
    client_id            = var.client_id
    resource_group_name  = var.resource_group_name
    storage_account_name = var.storage_account_name
    container_name       = var.container_name
    key                  = var.key
  }
}

// Validations and local variables.
locals {
  environment = var.environment
  key         = var.key
}
