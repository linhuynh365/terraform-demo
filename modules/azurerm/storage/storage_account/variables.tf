#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  nullable    = false
  description = "The name for the storage account."
  type        = string
}

variable "resource_group_name" {
  nullable    = false
  description = "Name of the resource group where the resouce should be created."
  type        = string
}

variable "location" {
  nullable    = false
  description = "The location where the storage account should be created."
  type        = string
}

variable "account_tier" {
  description = "The tier for the storage account."
  nullable    = false
  default     = "Standard"
  type        = string
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The location you provided is not alowed. You need to choose one of the account_tier value from 'Standard or Premium'."
  }
}

variable "account_replication_type" {
  description = "The kind of replication you want for the data stored"
  nullable    = false
  default     = "LRS"
  type        = string
  validation {
    condition     = contains(["LRS", "GRS"], var.account_replication_type)
    error_message = "You provided invalid replication type. You need to choose one of the account replication type value from 'LRS or GRS'."
  }
}

variable "tags" {
  description = "The tags that are to be applied to the resource."
  nullable    = false
  type        = map(any)
}


variable "public_network_access_enabled" {
  description = "If the storage account should be accessible from public network."
  nullable    = false
  default     = false
  type        = bool
}

variable "network_rules_default_action" {
  description = "Specifies the default action of allow or deny when no other rules match."
  nullable    = false
  default     = "Allow"
  type        = string
  validation {
    condition     = contains(["Deny", "Allow"], var.network_rules_default_action)
    error_message = "The option you provided is not alowed. You need to choose one of the following options: 'Deny' or Allow'."
  }
}

variable "network_rules_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices."
  nullable    = false
  default     = ["Metrics", "Logging", "AzureServices"]
  type        = list(string)
  validation {
    condition     = alltrue([for value in var.network_rules_bypass : contains(["Metrics", "Logging", "AzureServices"], value)]) || (length(var.network_rules_bypass) == 1 && var.network_rules_bypass[0] == "None")
    error_message = "The option you provided is not alowed. Valid options are any combination of 'Logging', 'Metrics', 'AzureServices', or 'None'."
  }
}

variable "network_rules_ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed."
  nullable    = false
  default     = []
  type        = list(string)
  validation {
    condition     = alltrue([for value in var.network_rules_ip_rules : can(cidrnetmask(value))])
    error_message = "IP list must contain valid IPv4 CIDR block addresses."
  }
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled."
  nullable    = false
  default     = true
  type        = bool
}

