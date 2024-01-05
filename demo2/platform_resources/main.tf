#############################################################################
# TERRAFORM PROVIDERS 
#############################################################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.50.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

#############################################################################
# RESOURCES
#############################################################################

module "resource_group" {
  source   = "../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "virtual_network" {
  source              = "../modules/virtual_network"
  depends_on          = [module.resource_group]
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  name                = var.virtual_network_name
  address_space       = var.vnet_address_space
}
