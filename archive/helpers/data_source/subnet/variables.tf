#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The resource group name where the subnet exists."
  nullable    = false
  validation {
    condition     = var.resource_group_name != ""
    error_message = "Subnet's resource group name cannot be empty"
  }
}

variable "virtual_network_name" {
  type     = string
  default  = ""
  nullable = false
  validation {
    condition     = var.virtual_network_name != ""
    error_message = "Subnet's vnet name cannot be empty"
  }
}

variable "name" {
  type        = string
  default     = ""
  description = "Subnet's name."
  nullable    = false
  validation {
    condition     = var.name != ""
    error_message = "Subnet's name cannot be empty"
  }
}
