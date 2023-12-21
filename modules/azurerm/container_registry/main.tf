#############################################################################
# REQUIRED PROVIDER
#############################################################################

#  terraform {
#    required_providers {
#      azurerm = {
#        source  = "hashicorp/azurerm"
#      }
#    }
#    required_version = ">= 0.14.9"
#  }


# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_container_registry" "acr" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  tags                          = merge(var.tags, { "created_by" = "dep_terraform", "type" = "container_registry", "DatadogLogs" = "true", "DatadogMetrics" = "true" })

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  trust_policy {
    enabled = var.trust_policy_enabled
  }

  georeplications {
    location                = var.georeplications_location
    zone_redundancy_enabled = var.georeplications_zone_redundancy_enabled
    tags                    = merge(var.tags, { "created_by" = "dep_terraform", "type" = "container_registry", "DatadogLogs" = "true", "DatadogMetrics" = "true" })
  }

  retention_policy {
    days    = var.retention_policy_days
    enabled = var.retention_policy_enabled
  }
}

