#############################################################################
# REQUIRED PROVIDER
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = ">=3.0"
#     }
#   }
# }

# provider "azurerm" {
#   features {}
# }

#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = var.offer_type
  kind                = var.kind

  geo_location {
    location          = var.location
    failover_priority = var.failover_priority
  }
  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  ip_range_filter = var.ip_range_filter
  tags            = merge(var.tags, { "created_by" = "dep_terraform", "type" = "cosmosdb" })
}

resource "azurerm_cosmosdb_sql_database" "cosmossql_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  throughput          = var.throughput
}

resource "azurerm_cosmosdb_sql_container" "cosmos_sql_db_container" {
  name                  = var.database_container_name
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.cosmosdb_account.name
  database_name         = azurerm_cosmosdb_sql_database.cosmossql_db.name
  partition_key_path    = "/partitionKey"
  partition_key_version = 1
  throughput            = var.throughput

  indexing_policy {
    indexing_mode = var.indexing_mode

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }
}
