#############################################################################
# OUTPUTS
#############################################################################

output "resource_group" {
  value = {
    id       = module.resource_group.id
    name     = module.resource_group.name
    tags     = module.resource_group.tags
    location = module.resource_group.location
  }
  description = "The information on all resource groups."
}

# Network outputs
output "virtual_networks" {
  value = { for vn in module.virtual_network :
    vn.name => ({
      id            = vn.id
      name          = vn.name
      tags          = vn.tags
      location      = vn.location
      address_space = vn.address_space
      }
    )
  }
  description = "The information on all virtual networks."
}

# Subnets outputs
output "subnets" {
  value = { for sn in module.subnet :
    sn.name => ({
      id                   = sn.id
      name                 = sn.name
      virtual_network_name = sn.virtual_network_name
      address_prefixes     = sn.address_prefixes
      }
    )
  }
  description = "The information on all subnets"
}

# Environment Name
output "environment" {
  value = {
    name = local.environment
    type = local.environment_type
  }
  description = "The information on the environment."
}

# Container registry output
output "container_registries" {
  value = { for cr in module.container_registry :
    cr.name => ({
      id           = cr.id
      name         = cr.name
      tags         = cr.tags
      login_server = cr.login_server
      }
    )
  }
  description = "The information on all ACRs."
}

# Management Lock
output "management_lock" {
  value = { for ml in module.acr_management_lock :
    ml.id => ({
      id    = ml.id
      name  = ml.name
      scope = ml.scope
      }
    )
  }
  description = "The information of lock."
}


// Key vault
output "keyvaults" {
  value = { for vault in module.keyvault :
    vault.name => ({
      id                   = vault.id
      name                 = vault.name
      tags                 = vault.tags
      virtual_network_name = vault.vault_uri
      }
    )
  }
  description = "The information on all Keyvaults."
}

// Azure Kubernetes Service 
output "azure_kubernetes_services" {
  value = { for aks in module.azure_kubernetes_cluster :
    aks.name => ({
      id                  = aks.id
      name                = aks.name
      tags                = aks.tags
      private_fqdn        = aks.private_fqdn
      node_resource_group = aks.node_resource_group

      kubelet_identity_object_id = aks.kubelet_identity_object_id

      }
    )
  }
  description = "Looping environment to fetch Azure kubernetes cluster's data."
}

// Log Analytics Workspace output
output "log_analytics_workspaces" {
  value = { for law in module.log_analytics_workspace :
    law.name => (
      {
        id           = law.id
        name         = law.name
        tags         = law.tags
        workspace_id = law.workspace_id
      }
    )
  }
  description = "The information on all the Log Analytics Workspaces."
}

// Cosmos DB

# output "azure_cosmosdb_hostname" {
#   description = "The hostname of created cosmos db"
#   value       = module.cosmos_db[0].hostname
# }

output "acr_private_dns_zones" {
  value = { for pdz in module.acr_private_dns_zone :
    pdz.name => (
      {
        id   = pdz.id
        name = pdz.name

      }
    )
  }
  description = "The information on all the private DNS zones."
}

output "acr_private_dns_zone_virtual_network_links" {
  value = { for pdzvnl in module.acr_private_dns_zone_virtual_network_link :
    pdzvnl.name => (
      {
        id   = pdzvnl.id
        name = pdzvnl.name
        tags = pdzvnl.tags
      }
    )
  }
  description = "The information on all the private DNS zone virtual network links."
}

// Private endpoint for ACR
output "acr_private_endpoints" {
  value = { for pe in module.acr_private_endpoint :
    pe.name => (
      {
        id   = pe.id
        name = pe.name
        tags = pe.tags
      }
    )
  }
  description = "The information on all the private endpoints."
}

// Application Gateway
# output "app_gateways" {
#   value = { for ag in module.app_gateway :
#     ag.name => (
#       {
#         id                   = ag.id
#         name                 = ag.name
#         tags                 = ag.tags
#         backend_address_pool = ag.backend_address_pool
#         public_ip_id         = module.app_gateway_public_ip[0].id
#       }
#     )
#   }
#   description = "The information on all the application gateway."
# }

# output "public_ips" {
#   value = { for pi in module.app_gateway_public_ip :
#     pi.name => (
#       {
#         id                = pi.id
#         name              = pi.name
#         tags              = pi.tags
#         ip_address        = pi.ip_address
#         domain_name_label = pi.domain_name_label
#         fqdn              = pi.fqdn
#       }
#     )
#   }
#   description = "The information on all the public IPs."
# }

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
    "${ara.role_definition_name}-${ara.principal_id}-${ara.scope}" => (
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

output "acr_azurerm_role_assignments" {
  value = { for ara in module.acr_azurerm_role_assignment :
    "${ara.role_definition_name}-${ara.principal_id}" => (
      {
        id                   = ara.id
        scope                = ara.scope
        principal_id         = ara.principal_id
        role_definition_name = ara.role_definition_name
      }
    )
  }
  description = "The output information on ACR role assignments."
}

output "aks_acr_pull_azurerm_role_assignments" {
  value = { for ara in module.aks_acr_pull_azurerm_role_assignment :
    "${ara.role_definition_name}-${ara.principal_id}-${ara.scope}" => (
      {
        id                   = ara.id
        scope                = ara.scope
        principal_id         = ara.principal_id
        role_definition_name = ara.role_definition_name
      }
    )
  }
  description = "The output information on ACR role assignments."
}

output "keyvault_azurerm_role_assignments" {
  value = { for ara in module.keyvault_azurerm_role_assignment :
    "${ara.role_definition_name}-${ara.principal_id}-${ara.scope}" => (
      {
        id                   = ara.id
        scope                = ara.scope
        principal_id         = ara.principal_id
        role_definition_name = ara.role_definition_name
    })
  }
  description = "The output information on Key Vault role assignments."
}

output "federated_identity_credentials" {
  value = { for fic in module.federated_identity_credential :
    fic.name => (
      {
        id                  = fic.id
        name                = fic.name
        resource_group_name = fic.resource_group_name
        audience            = fic.audience
        issuer              = fic.issuer
        parent_id           = fic.parent_id
        subject             = fic.subject
      }
    )
  }
  description = "The output information on federated identity credentials."
}

output "aks_keyvault_azurerm_role_assignments" {
  value = { for ara in module.aks_keyvault_azurerm_role_assignment :
    "${ara.role_definition_name}-${ara.principal_id}-${ara.scope}" => (
      {
        id                   = ara.id
        scope                = ara.scope
        principal_id         = ara.principal_id
        role_definition_name = ara.role_definition_name
      }
    )
  }
  description = "The output information on AKS - key vault role assignments."
}
