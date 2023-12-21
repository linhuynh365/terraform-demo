#############################################################################
# OUTPUTS
#############################################################################

# Environment Name
output "environment" {
  value = {
    name = local.environment
    type = local.environment_type
  }
  description = "The information on environment."
}

# Resource group output
output "resource_group" {
  value = {
    id       = module.resource_group.id
    name     = module.resource_group.name
    location = module.resource_group.location
  }
  description = "The information on all the resource groups."
}

# Application Insights output
output "application_insights" {
  value = { for app_insights in module.application_insights :
    app_insights.id => (
      {
        id     = app_insights.id
        app_id = app_insights.app_id
        # instrumentation_key = app_insights.instrumentation_key
        # connection_string   = app_insights.connection_string
      }
    )
  }
  description = "The information on all the Application Insight apps."
}

# cosmos db
output "cosmosdb_account_endpoints" {
  value = { for cosmos_db in module.cosmos_db :
    cosmos_db.name => ({
      account_endpoint = cosmos_db.account_endpoint
      }
    )
  }
  description = "The account endpoint of created cosmos db."
}

// Traffic Manager profile
output "traffic_manager_profiles" {
  value = { for tmp in module.traffic_manager_profile :
    tmp.name => (
      {
        id                     = tmp.id
        fqdn                   = tmp.fqdn
        name                   = tmp.name
        tags                   = tmp.tags
        traffic_routing_method = tmp.traffic_routing_method
      }
    )
  }
  description = "The information on all the Traffic Manager profile."
}

// Traffic Manager azure endpoint Performance
output "traffic_manager_azure_endpoints" {
  value = { for tmaep in module.traffic_manager_azure_endpoint :
    tmaep.name => (
      {
        id   = tmaep.id
        name = tmaep.name
      }
    )
  }
  description = "The output information for traffic manager azure endpoint."
}

# Managed Identity

output "user_managed_identities" {
  value = { for mi in module.user_assigned_managed_identity :
    mi.name => (
      {
        name         = mi.name
        principal_id = mi.principal_id
        id           = mi.id
        tags         = mi.tags
      }
    )
  }
  description = "The output information on user assigned managed identity."
}

output "role_assignments" {
  value = { for ara in module.azurerm_role_assignment :
    "${ara.scope}-${ara.role_definition_name}" => (
      {
        id                   = ara.id
        scope                = ara.scope
        principal_id         = ara.principal_id
        role_definition_name = ara.role_definition_name
      }
    )
  }
  description = "The output information on role assignments."
}
