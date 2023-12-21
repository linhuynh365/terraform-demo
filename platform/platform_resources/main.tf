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

# backend "azurerm" {

#   # Auth with secret.
#   tenant_id = "8ac76c91-e7f1-41ff-a89c-3553b2da2c17"
#   # env.ARM_TENANT_ID
#   subscription_id = "535d8700-ff37-4ffe-85fc-7d2ba7352a66"
#   # env.ARM_SUBSCRIPTION_ID
#   client_id = "8325f696-03bb-4d3c-acf6-85ea996dc863"
#   # env.ARM_CLIENT_ID
#   # client_secret = var.DEP_TERRAFORM_REMOTE_STATE_CLIENT_SECRET
#   # env.ARM_CLIENT_SECRET
#   resource_group_name  = "zuse1-taa-dxg-rg-p1-depdata1"
#   storage_account_name = "zuse1taadxgstp1depdata1"
#   container_name       = "zuse1-taa-dxg-stct-p1-depdata1"
#   key                  = "dep_control_plane.tfstate"
#   }
# }

# provider "azurerm" {
#   features {}
# }
# subscription_id   = "<azure_subscription_id>"
# tenant_id         = "<azure_subscription_tenant_id>"
# client_id         = "<service_principal_appid>"
# client_secret     = "<service_principal_password>"
# export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
# export ARM_TENANT_ID="<azure_subscription_tenant_id>"
# export ARM_CLIENT_ID="<service_principal_appid>"
# export ARM_CLIENT_SECRET="<service_principal_password>"
# }


#############################################################################
# RESOURCES
#############################################################################

module "name_generator" {
  source             = "../../modules/helpers/naming"
  cloud_code         = var.cloud_code
  country_code       = var.country_code
  region_code        = var.region_code
  division_code      = var.division_code
  business_unit_code = var.business_unit_code
  environment_code   = var.environment_code
  environment_number = var.environment_number
  app_name_code      = var.app_name_code
  app_suffix_number  = var.app_suffix_number
}

module "resource_group" {
  source   = "../../modules/azurerm/resource_group"
  name     = module.name_generator.resource_group_name
  location = var.location
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

module "network_ddos_protection_plan" {
  source              = "../../modules/azurerm/networking/network_ddos_protection_plan"
  depends_on          = [module.resource_group, module.name_generator]
  count               = var.createVnet == true ? 1 : 0
  name                = module.name_generator.network_ddos_protection_plan_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division
    }
  )
}

module "virtual_network" {
  source                  = "../../modules/azurerm/networking/vnet"
  depends_on              = [module.resource_group, module.network_ddos_protection_plan]
  count                   = var.createVnet == true ? 1 : 0
  resource_group_name     = module.resource_group.name
  ddos_protection_plan_id = module.network_ddos_protection_plan[0].id
  location                = module.resource_group.location
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division
    }
  )
  name          = module.name_generator.virtual_network_name
  address_space = ["${var.vnet_address_space}"]
}

module "subnet" {
  source               = "../../modules/azurerm/networking/subnet"
  depends_on           = [module.virtual_network]
  for_each             = var.subnets
  resource_group_name  = module.resource_group.name
  virtual_network_name = length(module.virtual_network) > 0 ? module.virtual_network[0].name : ""
  name                 = format("%s%s%s", module.name_generator.subnet_name, "-", each.value.name)
  address_prefixes     = each.value.prefixes
}

# Management Lock 

module "acr_management_lock" {
  source     = "../../modules/azurerm/management_lock"
  depends_on = [module.container_registry]
  count      = var.createAcrLock == true ? 1 : 0
  lock_name  = "${module.container_registry[0].name}-lock"
  lock_level = var.lock_level
  scope      = module.container_registry[0].id
  notes      = var.notes
}

// Azure Kubernetes Service
module "azure_kubernetes_cluster" {
  source                  = "../../modules/azurerm/aks"
  depends_on              = [module.resource_group, module.virtual_network, module.subnet]
  count                   = var.createAks == true ? 1 : 0
  name                    = module.name_generator.kubernetes_cluster_name
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  dns_prefix              = module.name_generator.kubernetes_cluster_name
  resource_group_id       = module.resource_group.id
  private_cluster_enabled = var.aks_private_cluster_enabled
  vnet_subnet_id          = one(([for each in module.subnet : each.name if each.name == (format("%s%s%s", module.name_generator.subnet_name, "-", var.aks_vnet_subnet_id_suffix))]))
  sku_tier                = var.aks_sku_tier
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

# Can remove once datadog is implemented to monitor keyvault
module "keyvault_monitor_storage_account" {
  source              = "../../modules/azurerm/storage/storage_account"
  depends_on          = [module.name_generator, module.resource_group]
  count               = var.createKeyvault ? 1 : 0
  name                = module.name_generator.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division
      "environment_type"    = var.environment_type
    }
  )
}

// Subnet data source for key vault
module "keyvault_acl_subnet_data_source" {
  source               = "../../modules/helpers/data_source/subnet"
  for_each             = var.keyvault_acl_subnet_list
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

// Key vault
module "keyvault" {
  source                        = "../../modules/azurerm/keyvault"
  depends_on                    = [module.name_generator, module.resource_group, module.keyvault_monitor_storage_account, module.keyvault_acl_subnet_data_source]
  count                         = var.createKeyvault ? 1 : 0
  name                          = module.name_generator.key_vault_name
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  soft_delete_retention_days    = var.keyvault_soft_delete_retention_days
  purge_protection_enabled      = var.keyvault_purge_protection_enabled
  sku_name                      = var.keyvault_sku
  public_network_access_enabled = var.keyvault_public_network_access_enabled
  virtual_network_subnet_ids    = [for subnet in module.keyvault_acl_subnet_data_source : subnet.id]
  # Can replace storage account id with partner solution id if moving to Datadog for logging
  storage_account_id = module.keyvault_monitor_storage_account[0].id
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

// Log Analytics Workspace
module "log_analytics_workspace" {
  source              = "../../modules/azurerm/log_analytics_workspace"
  depends_on          = [module.resource_group]
  count               = var.createLoganalyticsws == true ? 1 : 0
  name                = module.name_generator.log_analytics_workspace_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  retention_in_days   = var.workspace_retention_in_days
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

// Azure Container Registry
module "container_registry" {
  source                        = "../../modules/azurerm/container_registry"
  depends_on                    = [module.resource_group]
  count                         = var.createAcr == true ? 1 : 0
  name                          = module.name_generator.container_registry_name
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  sku                           = var.acr_sku
  public_network_access_enabled = var.acr_public_network_access_enabled
  quarantine_policy_enabled     = var.acr_quarantine_policy_enabled
  identity_type                 = var.acr_identity_type
  identity_ids                  = (var.acr_identity_type == "UserAssigned" || var.acr_identity_type == "SystemAssigned, UserAssigned") ? [module.user_assigned_managed_identity[0].id] : []
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
  trust_policy_enabled                    = var.acr_trust_policy_enabled
  georeplications_location                = var.acr_georeplications_location
  georeplications_zone_redundancy_enabled = var.acr_georeplications_zone_redundancy_enabled
  retention_policy_days                   = var.acr_retention_policy_days
  retention_policy_enabled                = var.acr_retention_policy_enabled
}

// Vnet data source for ACR private endpoint
module "acr_private_endpoint_vnet_data_source" {
  source              = "../../modules/helpers/data_source/virtual_network"
  count               = (var.createACRPrivateEndpoint && var.acr_private_endpoint_vnet_name != "" && var.acr_private_endpoint_vnet_resource_group_name != "") ? 1 : 0
  name                = var.acr_private_endpoint_vnet_name
  resource_group_name = var.acr_private_endpoint_vnet_resource_group_name
}

// Subnet data source for ACR private endpoint
module "acr_private_endpoint_subnet_data_source" {
  source               = "../../modules/helpers/data_source/subnet"
  depends_on           = [module.acr_private_endpoint_vnet_data_source]
  count                = (var.createACRPrivateEndpoint && length(module.acr_private_endpoint_vnet_data_source) > 0) ? 1 : 0
  name                 = one([for subnet_name in module.acr_private_endpoint_vnet_data_source[0].subnets : subnet_name if can(regex("cre0", subnet_name))]) # Always use subnet that ends with cre0 for ACR's private endpoint
  virtual_network_name = var.acr_private_endpoint_vnet_name
  resource_group_name  = var.acr_private_endpoint_vnet_resource_group_name
}

// Remote state data source for ACR private endpoint
module "environment_acr_remote_state_data_source" {
  source      = "../../modules/helpers/data_source/remote_state"
  environment = "acr_${var.environment_type}"
  key         = "dep_cont_reg/${var.environment_type}.tfstate"
}

module "pe_acr_remote_states" {
  source      = "../../modules/helpers/data_source/remote_state"
  count       = length(var.pe_acr_environment_list)
  environment = "acr_${var.pe_acr_environment_list[count.index]}"
  key         = "dep_cont_reg/${var.pe_acr_environment_list[count.index]}.tfstate"
}

// Private dns endpoint for ACR private endpoint
module "acr_private_dns_zone" {
  source              = "../../modules/azurerm/networking/private_dns_zone"
  depends_on          = [module.resource_group]
  name                = "privatelink.azurecr.io"
  count               = var.createACRPrivateEndpoint ? 1 : 0
  resource_group_name = module.resource_group.name
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

// Private link for ACR private endpoint
module "acr_private_dns_zone_virtual_network_link" {
  source                = "../../modules/azurerm/networking/private_dns_zone_virtual_network_link"
  count                 = (var.createACRPrivateEndpoint && var.acr_private_endpoint_vnet_name != "" && var.acr_private_endpoint_vnet_resource_group_name != "") ? 1 : 0
  depends_on            = [module.resource_group, module.acr_private_dns_zone, module.acr_private_endpoint_vnet_data_source]
  name                  = module.name_generator.private_link_service_name
  private_dns_zone_name = length(module.acr_private_dns_zone) > 0 ? module.acr_private_dns_zone[count.index].name : ""
  resource_group_name   = module.resource_group.name
  virtual_network_id    = module.acr_private_endpoint_vnet_data_source[0].id
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

// Private endpoint for ACR 
module "acr_private_endpoint" {
  source                      = "../../modules/azurerm/networking/private_endpoint"
  count                       = (var.createACRPrivateEndpoint && var.acr_private_endpoint_vnet_name != "" && var.acr_private_endpoint_vnet_resource_group_name != "") ? length(local.pe_acr_ids) : 0
  depends_on                  = [module.resource_group, module.virtual_network, module.subnet, module.container_registry, module.acr_private_dns_zone, module.acr_private_dns_zone_virtual_network_link, module.acr_private_endpoint_subnet_data_source]
  name                        = "${module.name_generator.private_endpoint_name}-${local.pe_acr_ids[count.index].environment}"
  resource_group_name         = module.resource_group.name
  location                    = module.resource_group.location
  subnet_id                   = module.acr_private_endpoint_subnet_data_source[0].id
  private_connection_name     = module.name_generator.private_service_connection_name
  private_resource_id         = local.pe_acr_ids[count.index].id
  subresource_name            = "registry"
  private_dns_zone_group_name = module.name_generator.private_dns_zone_group_name
  private_dns_zone_ids        = [module.acr_private_dns_zone[0].id]
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division,
      "environment_type"    = var.environment_type
    }
  )
}

// Public IP
# module "app_gateway_public_ip" {
#   source              = "../../modules/azurerm/networking/public_ip"
#   count               = var.createAppGateway ? 1 : 0
#   depends_on          = [module.name_generator, module.resource_group]
#   name                = module.name_generator.public_ip_name
#   resource_group_name = module.resource_group.name
#   location            = module.resource_group.location
#   allocation_method   = var.app_gateway_public_ip_allocation_method
#   sku                 = "Standard" # Required to be Standard when used with app gateway
#   domain_name_label   = module.name_generator.dns_a_record_name

#   tags = tomap(
#     {
#       "workload_name"       = var.workload_name,
#       "data_classification" = var.data_classification,
#       "criticality"         = var.criticality,
#       "business_unit"       = var.business_unit,
#       "ops_team"            = var.ops_team,
#       "cost_center"         = var.cost_center,
#       "environment"         = var.environment,
#       "owner"               = var.owner,
#       "disaster_recovery"   = var.disaster_recovery,
#       "organization"        = var.organization,
#       "division"            = var.division
#       "environment_type"    = var.environment_type
#     }
#   )
# }

# // Application Gateway
# module "app_gateway" {
#   source                             = "../../modules/azurerm/networking/app_gateway"
#   count                              = var.createAppGateway ? 1 : 0
#   depends_on                         = [module.resource_group, module.app_gateway_public_ip]
#   name                               = module.name_generator.application_gateway_name
#   resource_group_name                = module.resource_group.name
#   location                           = module.resource_group.location
#   sku                                = var.app_gateway_sku
#   gateway_ip_configuration_name      = var.app_gateway_ip_configuration_name
#   subnet_frontend_id                 = var.app_gateway_subnet_frontend_id
#   frontend_port_name                 = "${module.name_generator.application_gateway_name}-feport"
#   frontend_port_number               = var.app_gateway_frontend_port_number
#   frontend_ip_configuration_name     = "${module.name_generator.application_gateway_name}-feip"
#   public_ip_address_id               = module.app_gateway_public_ip[0].id
#   backend_address_pool_name          = "${module.name_generator.application_gateway_name}-beap"
#   backend_address_pool_ip_adresses   = var.app_gateway_backend_address_pool_ip_adresses
#   backend_address_pool_fqdns         = var.app_gateway_backend_address_pool_fqdns
#   backend_http_setting_name          = "${module.name_generator.application_gateway_name}-be-htst"
#   backend_http_cookie_based_affinity = var.app_gateway_backend_http_cookie_based_affinity
#   backend_http_path                  = var.app_gateway_backend_http_path
#   backend_http_port                  = var.app_gateway_backend_http_port
#   backend_http_protocol              = var.app_gateway_backend_http_protocol
#   backend_http_request_timeout       = var.app_gateway_backend_http_request_timeout
#   http_listener_name                 = "${module.name_generator.application_gateway_name}-httplstn"
#   http_listener_protocol             = var.app_gateway_http_listener_protocol
#   request_routing_rule_name          = "${module.name_generator.application_gateway_name}-rqrt"
#   request_routing_rule_type          = var.app_gateway_request_routing_rule_type
#   request_routing_rule_priority      = var.app_gateway_request_routing_rule_priority
#   ssl_certificate_name               = var.app_gateway_ssl_certificate_name
#   key_vault_secret_id                = var.app_gateway_key_vault_secret_id
#   identity_ids                       = var.app_gateway_identity_ids
#   min_capacity                       = var.app_gateway_min_capacity
#   max_capacity                       = var.app_gateway_max_capacity

#   tags = tomap(
#     {
#       "workload_name"       = var.workload_name,
#       "data_classification" = var.data_classification,
#       "criticality"         = var.criticality,
#       "business_unit"       = var.business_unit,
#       "ops_team"            = var.ops_team,
#       "cost_center"         = var.cost_center,
#       "environment"         = var.environment,
#       "owner"               = var.owner,
#       "disaster_recovery"   = var.disaster_recovery,
#       "organization"        = var.organization,
#       "division"            = var.division
#       "environment_type"    = var.environment_type
#     }
#   )
# }

module "user_assigned_managed_identity" {
  source              = "../../modules/azurerm/access_management/user_assigned_managed_identity"
  depends_on          = [module.resource_group, module.name_generator]
  count               = var.createUserManagedIdentity ? 1 : 0
  name                = module.name_generator.user_assigned_identity_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  tags = tomap(
    {
      "workload_name"       = var.workload_name,
      "data_classification" = var.data_classification,
      "criticality"         = var.criticality,
      "business_unit"       = var.business_unit,
      "ops_team"            = var.ops_team,
      "cost_center"         = var.cost_center,
      "environment"         = var.environment,
      "owner"               = var.owner,
      "disaster_recovery"   = var.disaster_recovery,
      "organization"        = var.organization,
      "division"            = var.division
      "environment_type"    = var.environment_type
    }
  )
}

module "acr_azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.container_registry]
  count                = var.createAcr ? length(var.acr_pull_assignment_principal_id_list) : 0
  role_definition_name = "AcrPull"
  scope                = module.container_registry[0].id
  principal_id         = var.acr_pull_assignment_principal_id_list[count.index]
}

module "aks_acr_pull_acr_remote_states" {
  source      = "../../modules/helpers/data_source/remote_state"
  count       = length(var.aks_acr_pull_environment_list)
  environment = "acr_${var.aks_acr_pull_environment_list[count.index]}"
  key         = "dep_cont_reg/${var.aks_acr_pull_environment_list[count.index]}.tfstate"
}

module "aks_acr_pull_azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.caas_aks_data_source, module.aks_acr_pull_acr_remote_states, module.environment_acr_remote_state_data_source]
  count                = var.enableAcrPullForAks && length(module.caas_aks_data_source) > 0 ? length(local.aks_acr_pull_acr_ids) : 0
  role_definition_name = "AcrPull"
  scope                = local.aks_acr_pull_acr_ids[count.index]
  principal_id         = module.caas_aks_data_source[0].kubelet_identity.0.object_id
}

module "aks_keyvault_azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.caas_aks_data_source, module.keyvault]
  count                = var.enableKeyVaultAdminForAks ? 1 : 0
  role_definition_name = "Key Vault Administrator"
  scope                = module.keyvault[0].id
  principal_id         = module.caas_aks_data_source[0].key_vault_secrets_provider.0.secret_identity.0.object_id
}

module "keyvault_azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.user_assigned_managed_identity, module.keyvault, module.federated_identity_credential]
  count                = var.createKeyvault && var.createFederatedIdentityCredential && var.createUserManagedIdentity ? 1 : 0
  role_definition_name = "Key Vault Administrator"
  scope                = module.keyvault[0].id
  principal_id         = module.user_assigned_managed_identity[0].principal_id
}

module "azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.user_assigned_managed_identity]
  for_each             = { for ra in local.role_assignment_scope : ra.role_definition_name => ra }
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
  principal_id         = var.createUserManagedIdentity ? module.user_assigned_managed_identity[0].principal_id : each.value.role_assignment_principal_id
}

module "caas_aks_data_source" {
  source              = "../../modules/helpers/data_source/aks"
  count               = (var.createFederatedIdentityCredential || var.enableAcrPullForAks) && var.caas_aks_name != "" && var.caas_aks_resource_group_name != "" ? 1 : 0
  name                = var.caas_aks_name
  resource_group_name = var.caas_aks_resource_group_name
}

module "federated_identity_credential" {
  source              = "../../modules/azurerm/access_management/federated_identity_credential"
  depends_on          = [module.resource_group, module.user_assigned_managed_identity, module.name_generator, module.caas_aks_data_source]
  count               = var.createFederatedIdentityCredential && var.createUserManagedIdentity ? 1 : 0
  name                = "${module.user_assigned_managed_identity[0].name}-federated"
  resource_group_name = module.resource_group.name
  issuer              = module.caas_aks_data_source[0].oidc_issuer_url
  audience            = ["api://AzureADTokenExchange"]
  parent_id           = module.user_assigned_managed_identity[0].id
  subject             = "system:serviceaccount:${var.federated_identity_credential_service_account_namespace}:${var.federated_identity_credential_service_account_name}"
}

// Validations and local variables.
locals {
  environment                     = var.environment
  environment_type                = var.environment_type
  environment_acr_remote_state_id = module.environment_acr_remote_state_data_source.outputs.container_registries[one([for key in keys(module.environment_acr_remote_state_data_source.outputs.container_registries) : key if can(regex("acr", key))])].id
  pe_acr_ids                      = [for data_source in module.pe_acr_remote_states : { "environment" : data_source.environment, "id" : data_source.outputs.container_registries[one([for key in keys(data_source.outputs.container_registries) : key if can(regex("acr", key))])].id }]
  aks_acr_pull_acr_ids            = length(var.aks_acr_pull_environment_list) == 0 ? [local.environment_acr_remote_state_id] : [for data_source in module.aks_acr_pull_acr_remote_states : data_source.outputs.container_registries[one([for key in keys(data_source.outputs.container_registries) : key if can(regex("acr", key))])].id]

  validate_acrlock_not_creation = var.createAcr == false && var.createAcrLock == true
  validate_acrlock_not_msg      = "You cannot create a lock for ACR if you are not creating an ACR."
  validate_acrlock_not_chk      = regex("^${local.validate_acrlock_not_msg}$", (!local.validate_acrlock_not_creation ? local.validate_acrlock_not_msg : ""))

  validate_acr_with_user_assigned_creation = (var.acr_identity_type == "UserAssigned" || var.acr_identity_type == "SystemAssigned, UserAssigned") && var.createUserManagedIdentity == false
  validate_acr_with_user_assigned_msg      = "You cannot have identity type for ACR as \"UserAssigned\" or \"SystemAssigned, UserAssigned\" without create user assigned managed identity."
  validate_acr_with_user_assigned_chk      = regex("^${local.validate_acr_with_user_assigned_msg}$", (!local.validate_acr_with_user_assigned_creation ? local.validate_acr_with_user_assigned_msg : ""))

  validate_subnet_not_creation = var.createVnet == false && length(var.subnets) > 0
  validate_subnet_not_msg      = "You cannot create a subnet if you are not creating a vnet, don't set subnets value."
  validate_subnet_not_chk      = regex("^${local.validate_subnet_not_msg}$", (!local.validate_subnet_not_creation ? local.validate_subnet_not_msg : ""))

  validate_subnet_creation = var.createVnet == true && length(var.subnets) < 1
  validate_subnet_msg      = "You have to create subnets when you create a vnet."
  validate_subnet_chk      = regex("^${local.validate_subnet_msg}$", (!local.validate_subnet_creation ? local.validate_subnet_msg : ""))

  validate_aks_creation = var.createVnet == false && var.createAks == true
  validate_aks_msg      = "You cannot create a aks if you are not creating a network, set CreateAks to false."
  validate_aks_chk      = regex("^${local.validate_aks_msg}$", (!local.validate_aks_creation ? local.validate_aks_msg : ""))

  # validate_mi_creation = var.createUserManagedIdentity == true && var.useExistingUserManagedIdentity == true
  # validate_mi_msg      = "You cannot enable createUserManagedIdentity and useExistingUserManagedIdentity, set useExistingUserManagedIdentity to false."
  # validate_mi_chk      = regex("^${local.validate_mi_msg}$", (!local.validate_mi_creation ? local.validate_mi_msg : ""))

  # Check for Application Gateway
  # validate_app_gateway_capacity     = var.createAppGateway == true && var.app_gateway_max_capacity < var.app_gateway_min_capacity
  # validate_app_gateway_capacity_msg = "You cannot have the minimum capacity bigger than the maximum capacity."
  # validate_app_gateway_capacity_chk = regex("^${local.validate_app_gateway_capacity_msg}$", (!local.validate_app_gateway_capacity ? local.validate_app_gateway_capacity_msg : ""))

  # Private endpoint validations
  validate_external_private_acr_endpoint     = var.createAcr == false && var.createACRPrivateEndpoint == true && length(local.pe_acr_ids) == 0
  validate_external_private_acr_endpoint_msg = "You cannot ACR private endpoint created if ACR remote state doesn't exist and new ACR is not created."
  validate_external_private_acr_endpoint_chk = regex("^${local.validate_external_private_acr_endpoint_msg}$", (!local.validate_external_private_acr_endpoint ? local.validate_external_private_acr_endpoint_msg : ""))

  validate_external_private_acr_endpoint_network     = var.createACRPrivateEndpoint == true && var.acr_private_endpoint_vnet_name == "" && var.acr_private_endpoint_vnet_resource_group_name == ""
  validate_external_private_acr_endpoint_network_msg = "VNET information such as name and resource group name must be given to create ACR private endpoint."
  validate_external_private_acr_endpoint_network_chk = regex("^${local.validate_external_private_acr_endpoint_network_msg}$", (!local.validate_external_private_acr_endpoint_network ? local.validate_external_private_acr_endpoint_network_msg : ""))

  validate_mi_type_creation = var.createUserManagedIdentity == true && length(var.role_assignment_principal_id_list) > 0
  validate_mi_type_msg      = "You cannot create user assigned managed identity and use existing managed identities at the same time."
  validate_mi_type_chk      = regex("^${local.validate_mi_type_msg}$", (!local.validate_mi_type_creation ? local.validate_mi_type_msg : ""))

  validate_mi_creation = length(var.role_assignment_scope_list) > 0 && (var.createUserManagedIdentity == false && length(var.role_assignment_principal_id_list) <= 0)
  validate_mi_msg      = "You cannot create role assignments without providing existing managed identities' principal ID or creating a new user managed indentity."
  validate_mi_chk      = regex("^${local.validate_mi_msg}$", (!local.validate_mi_creation ? local.validate_mi_msg : ""))

  role_assignment_principal_id_list = var.createUserManagedIdentity == true ? ["user-managed-identity-principal-id"] : var.role_assignment_principal_id_list
  role_assignment_scope = length(local.role_assignment_principal_id_list) > 0 && length(var.role_assignment_scope_list) > 0 ? flatten([
    for index, principal_id in local.role_assignment_principal_id_list : [
      for role_assignment_scope in var.role_assignment_scope_list : {
        role_definition_name         = role_assignment_scope.role_definition_name
        scope                        = role_assignment_scope.scope
        role_assignment_principal_id = local.role_assignment_principal_id_list[index]
      }
    ]
  ]) : []

  validate_federated_identity_creation = var.createFederatedIdentityCredential == true && var.createUserManagedIdentity == false
  validate_federated_identity_msg      = "You cannot create a federated identity credential without creating a user assigned managed identity."
  validate_federated_identity_chk      = regex("^${local.validate_federated_identity_msg}$", (!local.validate_federated_identity_creation ? local.validate_federated_identity_msg : ""))

  validate_federated_identity_creation_2 = var.createFederatedIdentityCredential == true && var.createKeyvault == false
  validate_federated_identity_msg_2      = "You cannot fully create a federate identity credential without creating a key vault for accessing secrets"
  validate_federated_identity_chk_2      = regex("^${local.validate_federated_identity_msg_2}$", (!local.validate_federated_identity_creation_2 ? local.validate_federated_identity_msg_2 : ""))

  validate_federated_identity_creation_3 = var.createFederatedIdentityCredential == true && (var.caas_aks_name == "" || var.caas_aks_resource_group_name == "")
  validate_federated_identity_msg_3      = "You cannot create federated identity credential without specifying the AKS name and resource group name"
  validate_federated_identity_chk_3      = regex("^${local.validate_federated_identity_msg_3}$", (!local.validate_federated_identity_creation_3 ? local.validate_federated_identity_msg_3 : ""))

  validate_acr_pull_aks_creation = var.enableAcrPullForAks == true && (var.caas_aks_name == "" || var.caas_aks_resource_group_name == "")
  validate_acr_pull_aks_msg      = "You cannot enable AcrPull for CAAS AKS without specifying the AKS name and resource group name"
  validate_acr_pull_aks_chk      = regex("^${local.validate_acr_pull_aks_msg}$", (!local.validate_acr_pull_aks_creation ? local.validate_acr_pull_aks_msg : ""))

  validate_keyvault_admin_permission_aks_creation = var.enableKeyVaultAdminForAks == true && (var.caas_aks_name == "" || var.caas_aks_resource_group_name == "")
  validate_keyvault_admin_permission_aks_msg      = "You cannot enable Key Vault Administration Role Assignment for CAAS AKS without specifying the AKS name and resource group name"
  validate_keyvault_admin_permission_aks_chk      = regex("^${local.validate_keyvault_admin_permission_aks_msg}$", (!local.validate_acr_pull_aks_creation ? local.validate_keyvault_admin_permission_aks_msg : ""))
}
