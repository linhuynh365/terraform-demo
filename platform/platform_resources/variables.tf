#############################################################################
# VARIABLES
#############################################################################

# Prefix

variable "cloud_code" {
  type        = string
  description = "The code assigned for cloud environment."
  nullable    = false
}

variable "country_code" {
  type        = string
  description = "The country code to be used for the resource"
  nullable    = false
}

variable "region_code" {
  type        = number
  description = "The region code to be used for the resource."
  nullable    = false
}

variable "division_code" {
  type        = string
  description = "The division code to be used for the environment."
  nullable    = false
}

variable "business_unit_code" {
  type        = string
  description = "The business unit code to be used for the environment."
  nullable    = false
}

# Suffix

variable "environment_code" {
  type        = string
  description = "The environment code to be used for the environment."
  nullable    = false
}

variable "environment_number" {
  type        = number
  default     = null
  description = "The environment number to be used for the environment."
  nullable    = true
}

variable "app_name_code" {
  type        = string
  description = "The application name code to be used for the environment."
  nullable    = false
}

variable "app_suffix_number" {
  type        = number
  default     = null
  description = "The sub resouce name code to be used for the environment."
  nullable    = true
}

###########################################################################

# variable "application" {
#   type        = string
#   description = "Name of the application, added to name suffix."
#   nullable    = false
# }

variable "environment" {
  type        = string
  description = "The environment."
  nullable    = false
}

variable "location" {
  type        = string
  description = "Where the resource need to be created."
  nullable    = false
}

# Resource Tags

variable "organization" {
  type        = string
  description = "Initials of the org, added to name prefix."
  nullable    = false
}

variable "division" {
  type        = string
  description = "Initials of the division, added to name prefix."
  nullable    = false
}

variable "workload_name" {
  type        = string
  description = "Name of the workload."
  nullable    = false
}

variable "data_classification" {
  type        = string
  description = "What classification of data the resource deals with."
  nullable    = false
}

variable "criticality" {
  type        = string
  description = "How critical are these resources."
  nullable    = false
}

variable "business_unit" {
  type        = string
  description = "Which business unit owns the resources."
  nullable    = false
}

variable "ops_team" {
  type        = string
  description = "Which team operates the resources."
  nullable    = false
}

variable "cost_center" {
  type        = string
  description = "Which cost center should the resource billed to."
  nullable    = false
}

variable "owner" {
  type        = string
  description = "The owner of the resource."
  nullable    = false
}

variable "disaster_recovery" {
  type        = string
  description = "The level of disaster recovery required."
  nullable    = false
}

variable "environment_type" {
  type        = string
  description = "The level of disaster recovery required."
  nullable    = false
  validation {
    condition     = contains(["dev", "nonprod", "prod"], var.environment_type)
    error_message = "The type of environment it is out of three categories. You need to choose one of the environment type from 'dev or nonprod or prod'."
  }
}

#Networking

variable "createVnet" {
  type        = bool
  description = "Set this true if you want to create a vnet. false otherwise"
  default     = false
  nullable    = false
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for virtual network like 10.0.0.0/16, should be from network team."
  default     = ""
  nullable    = false
}

variable "subnets" {
  type = map(object({
    name     = string,
    prefixes = list(string)
  }))
  nullable    = false
  default     = {}
  description = "The list of name and prefixes to use for creating subnets."
}

# Container Registry

variable "createAcr" {
  description = "Should a Container Registry be created."
  nullable    = false
  type        = bool
  default     = false
}

variable "acr_sku" {
  description = "The sku for container registry."
  nullable    = false
  type        = string
  default     = "Premium"
}

variable "acr_public_network_access_enabled" {
  description = "Weather the resource is accesible from the public network."
  nullable    = false
  type        = bool
  default     = false
}

variable "acr_quarantine_policy_enabled" {
  description = "Indicates whether quarantine policy is enabled."
  type        = bool
  default     = true
  nullable    = false
}


variable "acr_trust_policy_enabled" {
  description = "Enable Content Trust on ACR."
  type        = bool
  nullable    = false
  default     = true
}


variable "acr_georeplications_location" {
  description = "The Azure location where the container registry should be geo-replicated (sku must be Premium)."
  type        = string
  nullable    = false
  default     = "eastus"
}

variable "acr_georeplications_zone_redundancy_enabled" {
  description = "Weather or not to implement zone redundency."
  type        = bool
  default     = false
  nullable    = false
}

variable "acr_retention_policy_days" {
  type        = number
  description = "Number of days to retain."
  nullable    = false
  default     = 90
}

variable "acr_retention_policy_enabled" {
  type        = bool
  description = "Weather the reataintion policy be enabled"
  nullable    = false
  default     = true
}

# Lock

variable "createAcrLock" {
  description = "Whether to create resource lock"
  type        = bool
  nullable    = false
  default     = false
}

variable "lock_level" {
  type        = string
  description = "The level at which the lock should be applied"
  nullable    = false
  default     = "CanNotDelete"
}

variable "notes" {
  description = "The reason this lock is created."
  type        = string
  nullable    = true
  default     = "This lock cannot be deleted because of WK policy."
}

# Azure Kubernetes Cluster

variable "createAks" {
  description = "Should an AKS cluster be created."
  type        = bool
  nullable    = false
  default     = false
}

variable "aks_vnet_subnet_id_suffix" {
  description = "(Optional) The suffix for ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = "aks"
  nullable    = false
}

variable "aks_sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Standard (which includes the Uptime SLA). Defaults to Free."
  default     = "Standard"
  type        = string
  nullable    = false
}

variable "aks_private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

# // Key vault

variable "createKeyvault" {
  nullable    = false
  type        = bool
  description = "Creation of azure keyvault"
  default     = false
}

variable "keyvault_soft_delete_retention_days" {
  nullable    = false
  default     = 90
  type        = number
  description = "Soft delete retention days for keyvault"
}

variable "keyvault_purge_protection_enabled" {
  nullable    = false
  default     = false
  type        = bool
  description = "Purge protection enabled"
}

variable "keyvault_sku" {
  nullable    = false
  type        = string
  description = "SKU name for keyvault"
  default     = "standard"
}

variable "keyvault_public_network_access_enabled" {
  nullable    = false
  type        = bool
  description = "Enable if you need Public Access to Keyvault"
  default     = true
}

variable "keyvault_acl_subnet_list" {
  nullable    = true
  description = "(Optional) One or more Subnet IDs which should be able to access this Key Vault."
  type = map(object({
    subnet_name         = string,
    vnet_name           = string,
    resource_group_name = string
  }))
  default = {}
}

// Log Analytics workspace

variable "createLoganalyticsws" {
  nullable    = false
  type        = bool
  description = "Creation of azure log analytics workspace"
  default     = false
}

variable "workspace_retention_in_days" {
  type        = number
  nullable    = false
  description = " The workspace data retention in days."
  default     = 30
  validation {
    condition     = var.workspace_retention_in_days >= 30 && var.workspace_retention_in_days <= 730
    error_message = "The workspace data retention in days should be between 30 and 730."
  }
}

variable "createACRPrivateEndpoint" {
  description = "Whether to create private endpoint"
  type        = bool
  nullable    = true
  default     = false
}

variable "acr_private_endpoint_vnet_name" {
  type     = string
  nullable = true
  default  = ""
}

variable "acr_private_endpoint_vnet_resource_group_name" {
  type     = string
  nullable = true
  default  = ""
}

variable "acr_identity_ids" {
  type    = list(any)
  default = null
}

variable "acr_identity_type" {
  type     = string
  nullable = false
  default  = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.acr_identity_type)
    error_message = "The identity type you provided is not alowed. Choose one of the location from \"SystemAssigned\", \"UserAssigned\", \"SystemAssigned, UserAssigned\"."
  }
}

// Public IP
variable "app_gateway_public_ip_allocation_method" {
  type     = string
  nullable = true
  default  = "Static"
}

// App Gateway
# variable "createAppGateway" {
#   type        = bool
#   description = "Set this true if you want to create an app gateway. false otherwise"
#   default     = false
#   nullable    = true
# }

# variable "app_gateway_sku" {
#   nullable = false
#   type     = string
#   default  = "Standard_v2"
#   validation {
#     condition     = contains(["Standard_v2", "WAF_v2"], var.app_gateway_sku)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Standard_v2\", \"WAF_v2\"."
#   }
# }

# variable "app_gateway_ip_configuration_name" {
#   description = "Gateway IP Configuration Name"
#   nullable    = true
#   type        = string
#   default     = "app_gateway_ip_config"
# }

# variable "app_gateway_subnet_frontend_id" {
#   description = "Subnet Frontend ID for Gateway IP Configuration"
#   nullable    = true
#   type        = string
#   default     = ""
# }

# variable "app_gateway_frontend_port_number" {
#   nullable = false
#   type     = number
#   default  = 443
# }

# variable "app_gateway_backend_address_pool_ip_adresses" {
#   nullable = true
#   type     = list(string)
#   default  = []
# }

# variable "app_gateway_backend_address_pool_fqdns" {
#   nullable = true
#   type     = list(string)
#   default  = []
# }

# variable "app_gateway_backend_http_cookie_based_affinity" {
#   nullable = true
#   type     = string
#   default  = "Disabled"
#   validation {
#     condition     = contains(["Disabled", "Enabled"], var.app_gateway_backend_http_cookie_based_affinity)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Disabled\", \"Enabled\"."
#   }
# }

# variable "app_gateway_public_ip_address_id" {
#   description = "Public IP Address ID for frontend IP configuration"
#   nullable    = true
#   type        = string
#   default     = ""
# }

# variable "app_gateway_backend_http_path" {
#   nullable = true
#   type     = string
#   default  = "/"
# }

# variable "app_gateway_backend_http_port" {
#   nullable = false
#   type     = number
#   default  = 443
# }

# variable "app_gateway_backend_http_protocol" {
#   nullable = false
#   type     = string
#   default  = "Https"
#   validation {
#     condition     = contains(["Http", "Https"], var.app_gateway_backend_http_protocol)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Http\", \"Https\"."
#   }
# }

# variable "app_gateway_backend_http_request_timeout" {
#   nullable = true
#   type     = number
#   default  = 30
# }

# variable "app_gateway_http_listener_protocol" {
#   nullable = false
#   type     = string
#   default  = "Https"
#   validation {
#     condition     = contains(["Http", "Https"], var.app_gateway_http_listener_protocol)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Http\", \"Https\"."
#   }
# }

# variable "app_gateway_request_routing_rule_type" {
#   nullable = true
#   type     = string
#   default  = "Basic"
#   validation {
#     condition     = contains(["Basic", "PathBasedRouting"], var.app_gateway_request_routing_rule_type)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Basic\", \"PathBasedRouting\"."
#   }
# }

# variable "app_gateway_request_routing_rule_priority" {
#   nullable = true
#   type     = number
#   default  = 1
#   validation {
#     condition     = var.app_gateway_request_routing_rule_priority >= 1 && var.app_gateway_request_routing_rule_priority <= 20000
#     error_message = "Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority."
#   }
# }

# variable "app_gateway_ssl_certificate_name" {
#   nullable = true
#   type     = string
#   default  = ""
# }

# variable "app_gateway_key_vault_secret_id" {
#   nullable = true
#   type     = string
#   default  = ""
# }

# variable "app_gateway_identity_ids" {
#   nullable = true
#   type     = list(string)
#   default  = []
# }

# variable "app_gateway_min_capacity" {
#   description = "Minimum capacity for autoscaling."
#   nullable    = false
#   type        = number
#   default     = 0
#   validation {
#     condition     = var.app_gateway_min_capacity >= 0 && var.app_gateway_min_capacity <= 100
#     error_message = "Accepted values are in the range 0 to 100."
#   }
# }

# variable "app_gateway_max_capacity" {
#   description = "Maximum capacity for autoscaling."
#   nullable    = true
#   type        = number
#   default     = 2
#   validation {
#     condition     = var.app_gateway_max_capacity >= 2 && var.app_gateway_max_capacity <= 125
#     error_message = "Accepted values are in the range 2 to 125."
#   }
# }

## Managed Identity
variable "role_assignment_scope_list" {
  description = "The list of role asignment and soope"
  nullable    = false
  type = list(object({
    role_definition_name = string
    scope                = string
  }))
  default = []
  validation {
    condition     = length(var.role_assignment_scope_list) == 0 || (length(var.role_assignment_scope_list) > 0 && alltrue([for value in var.role_assignment_scope_list : can(length(value.role_definition_name) > 0) && can(length(value.scope) > 0)]))
    error_message = "If you are providing the list of role assignment and scope, you need to provide at least one role assignment and scope with proper values fro each field."
  }
}

variable "createUserManagedIdentity" {
  type        = bool
  description = "Set this true if you want to create a user assigned managed identity; false if use system identities."
  nullable    = true
  default     = false
}

variable "role_assignment_principal_id_list" {
  type        = list(string)
  description = "List of existing principal ids for role assignment."
  nullable    = false
  default     = []
}

# Federated Identity Credential
variable "createFederatedIdentityCredential" {
  type        = bool
  description = "Set this true if you want to create a federated identity credential"
  nullable    = true
  default     = false
}

variable "enableAcrPullForAks" {
  type        = bool
  description = "Set this true if you want to enable AcrPull for AKS. If this is set to true, caas_aks_name and caas_aks_resource_group_name are required."
  nullable    = true
  default     = false
}

variable "aks_acr_pull_environment_list" {
  description = "The list of environment ACRs that you want AKS to have AcrPull access. If this variable is not specified or given an empty list and variable enableAcrPullForAks is true, the system will assume you only want to grant AKS AcrPull to environment ACR only (based on variable environment_type)."
  type        = list(string)
  nullable    = true
  default     = []
}

variable "pe_acr_environment_list" {
  description = "The list of environment ACRs that you want to configure private endpoint."
  type        = list(string)
  nullable    = true
  default     = []
}

variable "acr_pull_assignment_principal_id_list" {
  type        = list(string)
  description = "List of existing principal ids for AcrPull role assignment."
  nullable    = false
  default     = []
}

variable "caas_aks_name" {
  description = "Specifies the AKS name for data sourcing."
  type        = string
  nullable    = false
  default     = ""
}

variable "caas_aks_resource_group_name" {
  description = "Specifies the AKS's resource group name for data sourcing."
  type        = string
  nullable    = false
  default     = ""
}

variable "federated_identity_credential_service_account_namespace" {
  description = "Namespace used to create federated service account."
  type        = string
  nullable    = false
  default     = "default"
}

variable "federated_identity_credential_service_account_name" {
  description = "Name used to create federated service account."
  type        = string
  nullable    = false
  default     = "federated_identity"
}

variable "enableKeyVaultAdminForAks" {
  type        = bool
  description = "Set this true if you want to enable Key Vault Administration Role Assignment for AKS. If this is set to true, caas_aks_name and caas_aks_resource_group_name are required."
  nullable    = true
  default     = false
}
