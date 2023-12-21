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
  default     = null
  description = "The environment code to be used for the environment."
  nullable    = true
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
    error_message = "The type of environment it is out of three categories. You need to choose one of environment type value from 'dev or nonprod or prod'."
  }
}

// Application Insights

variable "createApplicationinsights" {
  nullable    = false
  type        = bool
  description = "Creation of Application Insights"
  default     = false
}

variable "application_type" {
  type        = string
  nullable    = false
  default     = "web"
  description = "Specifies the type of Application Insights to create."
}

variable "daily_data_cap_in_gb" {
  type        = number
  nullable    = false
  default     = 100
  description = "Specifies the Application Insights component daily data volume cap in GB."
}

variable "daily_data_cap_notification_disabled" {
  type        = bool
  nullable    = false
  default     = true
  description = "Specifies if a notification email will be send when the daily data volume cap is met."
}

variable "app_insights_retention_in_days" {
  type        = number
  nullable    = false
  default     = 90
  description = " Specifies the retention period in days."
}

variable "sampling_percentage" {
  type        = number
  nullable    = false
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
}

variable "disable_ip_masking" {
  type        = bool
  nullable    = false
  default     = "true"
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. "
}

variable "log_analytics_workspace_id" {
  type        = string
  nullable    = true
  default     = ""
  description = "Id of log analytics workspace where the logs should be pushed."
}

// cosmos db

variable "createCosmosdb" {
  description = "Whether to create a cosmos db"
  type        = bool
  default     = false
  nullable    = false
}

variable "cosmosdb_offer_type" {
  description = "Offer type for cosmosdb"
  type        = string
  nullable    = false
  default     = "Standard"
}

variable "cosmosdb_kind" {
  description = "The kind for cosmosdb"
  type        = string
  nullable    = false
  default     = "GlobalDocumentDB"
}

variable "cosmosdb_failover_priority" {
  description = "The failover priority for cosmosdb"
  type        = number
  nullable    = false
  default     = 0
}

variable "cosmosdb_consistency_level" {
  description = "The level for consistency policy"
  type        = string
  nullable    = false
  default     = "BoundedStaleness"
}

variable "cosmosdb_throughput" {
  type        = number
  default     = 400
  description = "Cosmos db database throughput"
  nullable    = false
}

variable "cosmosdb_indexing_mode" {
  description = "The indexing mode for the container"
  type        = string
  nullable    = false
  default     = "consistent"
}

//Traffic Manager profile variables

variable "createTrafficManagerProfile" {
  description = "Whether to create traffic manager profile"
  type        = bool
  default     = false
  nullable    = false
}

variable "traffic_routing_method" {
  nullable    = false
  type        = string
  default     = "Performance"
  description = "routing method of traffic manager in azure"
  validation {
    condition     = contains(["Weighted", "Performance"], var.traffic_routing_method)
    error_message = "The traffic routing method you provided is not recommended. You need to choose one of traffic routing method value from 'Weighted or Performance'."
  }
}

variable "traffic_manager_relative_name" {
  nullable    = false
  type        = string
  default     = ""
  description = "The relative name of DNS"
}

variable "traffic_manager_ttl" {
  nullable    = false
  type        = number
  default     = 50
  description = "The ttl for DNS resolver in azure"
}

variable "traffic_manager_protocol" {
  nullable    = false
  type        = string
  default     = "HTTPS"
  description = "The protocol in azure"
}

variable "traffic_manager_port" {
  nullable    = false
  type        = number
  default     = 443
  description = "The port in azure"
}

variable "traffic_manager_path" {
  nullable    = false
  type        = string
  default     = "/"
  description = "The path of traffic manager in azure"
}

# Traffic Manager Azure Performance Endpoint

variable "createTrafficManagerEndpoint" {
  description = "Whether to create traffic manager endpoint"
  type        = bool
  default     = false
  nullable    = false
}

variable "traffic_manager_endpoint_public_ip_name" {
  nullable    = false
  type        = string
  default     = ""
  description = "The target resource's name"
}

variable "traffic_manager_endpoint_public_ip_resource_group_name" {
  nullable    = false
  type        = string
  default     = ""
  description = "The target resource's resource group name"
}

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
