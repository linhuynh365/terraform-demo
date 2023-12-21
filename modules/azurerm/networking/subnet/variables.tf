#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group we want to use."
  default     = ""
  validation {
    condition     = var.resource_group_name != ""
    error_message = "Subnet resource group name cannot be empty"
  }
}

variable "virtual_network_name" {
  type        = string
  nullable    = false
  description = "Name of the vnet where subnets are added."
  default     = ""
  validation {
    condition     = var.virtual_network_name != ""
    error_message = "Subnet virtual network name cannot be empty"
  }
}

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the subnet."
  default     = ""
  validation {
    condition     = var.name != ""
    error_message = "Subnet name cannot be empty"
  }
}

variable "address_prefixes" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "The prefixes for the subnet."
}

variable "service_endpoints" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "The service endpoints for the subnet."
}