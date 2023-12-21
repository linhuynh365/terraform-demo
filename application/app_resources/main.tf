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

#   required_version = "1.4.6"
#   backend "azurerm" {

#     # Auth with secret.
#     tenant_id = "8ac76c91-e7f1-41ff-a89c-3553b2da2c17"
#     # env.ARM_TENANT_ID
#     subscription_id = "535d8700-ff37-4ffe-85fc-7d2ba7352a66"
#     # env.ARM_SUBSCRIPTION_ID
#     client_id = "8325f696-03bb-4d3c-acf6-85ea996dc863"
#     # env.ARM_CLIENT_ID
#     # client_secret = var.DEP_TERRAFORM_REMOTE_STATE_CLIENT_SECRET
#     # env.ARM_CLIENT_SECRET

#     resource_group_name  = "zuse1-taa-dxg-rg-p1-depdata1"
#     storage_account_name = "zuse1taadxgstp1depdata1"
#     container_name       = "zuse1-taa-dxg-stct-p1-depdata1"
#     key                  = "dep_control_plane.tfstate"
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
      "division"            = var.division
      "environment_type"    = var.environment_type
    }
  )
}

// Application Insights
module "application_insights" {
  source                               = "../../modules/azurerm/app_insights"
  depends_on                           = [module.resource_group]
  count                                = var.createApplicationinsights == true ? 1 : 0
  name                                 = module.name_generator.application_insights_name
  resource_group_name                  = module.resource_group.name
  location                             = module.resource_group.location
  workspace_id                         = var.log_analytics_workspace_id
  application_type                     = var.application_type
  daily_data_cap_in_gb                 = var.daily_data_cap_in_gb
  daily_data_cap_notification_disabled = var.daily_data_cap_notification_disabled
  retention_in_days                    = var.app_insights_retention_in_days
  sampling_percentage                  = var.sampling_percentage
  disable_ip_masking                   = var.disable_ip_masking
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

// Cosmos DB
module "cosmos_db" {
  source                  = "../../modules/azurerm/cosmos_db"
  depends_on              = [module.resource_group]
  count                   = var.createCosmosdb == true ? 1 : 0
  name                    = module.name_generator.cosmosdb_account_name
  location                = module.resource_group.location
  resource_group_name     = module.resource_group.name
  offer_type              = var.cosmosdb_offer_type
  kind                    = var.cosmosdb_kind
  failover_priority       = var.cosmosdb_failover_priority
  consistency_level       = var.cosmosdb_consistency_level
  database_name           = "${module.name_generator.cosmosdb_account_name}-sqldb"
  throughput              = var.cosmosdb_throughput
  database_container_name = "${module.name_generator.cosmosdb_account_name}-sqldb-container"
  indexing_mode           = var.cosmosdb_indexing_mode

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

// Traffic Manager Profile

module "traffic_manager_profile" {
  source                 = "../../modules/azurerm/networking/traffic_manager_profile"
  depends_on             = [module.resource_group]
  count                  = var.createTrafficManagerProfile == true ? 1 : 0
  name                   = module.name_generator.traffic_manager_profile_name
  resource_group_name    = module.resource_group.name
  traffic_routing_method = var.traffic_routing_method
  relative_name          = var.traffic_manager_relative_name
  ttl                    = var.traffic_manager_ttl
  protocol               = var.traffic_manager_protocol
  port                   = var.traffic_manager_port
  path                   = var.traffic_manager_path
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

// Traffic Manager Azure Endpoint

module "traffic_manager_azure_endpoint_public_ip_data_source" {
  source              = "../../modules/helpers/data_source/public_ip"
  count               = var.createTrafficManagerEndpoint ? 1 : 0
  name                = var.traffic_manager_endpoint_public_ip_name
  resource_group_name = var.traffic_manager_endpoint_public_ip_resource_group_name
}

module "traffic_manager_azure_endpoint" {
  source             = "../../modules/azurerm/networking/traffic_manager_azure_endpoint"
  depends_on         = [module.traffic_manager_profile, module.traffic_manager_azure_endpoint_public_ip_data_source]
  count              = var.createTrafficManagerEndpoint ? 1 : 0
  name               = "${var.traffic_manager_endpoint_public_ip_name}-aep"
  profile_id         = length(module.traffic_manager_profile) > 0 ? module.traffic_manager_profile[0].id : ""
  target_resource_id = module.traffic_manager_azure_endpoint_public_ip_data_source[0].id
}

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

module "azurerm_role_assignment" {
  source               = "../../modules/azurerm/access_management/role_assignment"
  depends_on           = [module.user_assigned_managed_identity, module.name_generator]
  for_each             = { for ra in local.role_assignment_scope : ra.role_definition_name => ra }
  role_definition_name = each.value.role_definition_name
  scope                = each.value.scope
  principal_id         = var.createUserManagedIdentity ? module.user_assigned_managed_identity[0].principal_id : each.value.role_assignment_principal_id
}

// Validations and local variables.
locals {
  environment      = var.environment
  environment_type = var.environment_type

  # Check for Traffic Manager Endpoint
  validate_traffic_manager_azure_endpoint_creation     = var.createTrafficManagerEndpoint == true && length(module.traffic_manager_profile) <= 0
  validate_traffic_manager_azure_endpoint_creation_msg = "You cannot create traffic manager endpoint without a traffic manager profile."
  validate_traffic_manager_azure_endpoint_creation_chk = regex("^${local.validate_traffic_manager_azure_endpoint_creation_msg}$", (!local.validate_traffic_manager_azure_endpoint_creation ? local.validate_traffic_manager_azure_endpoint_creation_msg : ""))

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
}

