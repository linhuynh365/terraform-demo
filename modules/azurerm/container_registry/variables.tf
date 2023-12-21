#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the container registry."
}

variable "resource_group_name" {
  nullable    = false
  description = "The name of the resource group where the resource should be created."
}

variable "location" {
  nullable    = false
  description = "The location where this resource should be created."
  type        = string
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.location)
    error_message = "The location you provided is not alowed. Choose one of the location from 'centralus or eastus or eastus2'."
  }
}

variable "sku" {
  description = "The sku for container registry."
  nullable    = false
  type        = string
  default     = "Premium"
  validation {
    condition     = contains(["Premium"], var.sku)
    error_message = "The sku you provided is not alowed. You need to choose sku value as 'Premium'."
  }
}

variable "public_network_access_enabled" {
  description = "Weather the resource is accesible from the public network."
  nullable    = false
  type        = bool
}


variable "quarantine_policy_enabled" {
  description = "Indicates whether quarantine policy is enabled."
  type        = bool
  nullable    = false
}

variable "tags" {
  description = "The tags that are to be applied to the resource."
  nullable    = false
  type        = map(any)
}

variable "identity_type" {
  description = "The type of Managed Identity which should be assigned to the Container Registry. Possible values are 'SystemAssigned', 'UserAssigned' and 'SystemAssigned, UserAssigned'. If 'UserAssigned' is set, a 'user_assigned_identity_id' must be set as well."
  type        = string
  nullable    = false
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "The identity type you provided is not alowed. Choose one of the location from \"SystemAssigned\", \"UserAssigned\", \"SystemAssigned, UserAssigned\"."
  }
}

variable "identity_ids" {
  description = "(Optional) A list of User Managed Identity ID's which should be assigned to the Container Registry."
  type        = list(string)
  default     = []
}

variable "trust_policy_enabled" {
  description = "Enable Docker Content Trust on ACR."
  type        = bool
  nullable    = false
  default     = true
}

variable "georeplications_location" {
  description = "The location where the container registry should be replicated."
  type        = string
  nullable    = false
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.georeplications_location)
    error_message = "The location you provided is not alowed. Choose one of the location from 'centralus or eastus or eastus2'."
  }
}

variable "georeplications_zone_redundancy_enabled" {
  description = "value"
  type        = bool
  nullable    = false
}

variable "retention_policy_days" {
  type        = number
  description = "Number of days to retain."
  nullable    = false
}

variable "retention_policy_enabled" {
  type        = bool
  description = "Weather the reataintion policy be enabled"
  nullable    = false
}
