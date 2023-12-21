#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group where the resource should be created."
}

variable "name" {
  type        = string
  nullable    = false
  description = "Specifies the Name of Private DNS Zone Virtual Network Link."
}

variable "private_dns_zone_name" {
  type        = string
  nullable    = false
  description = "Specifies the Name of Private DNS Zone."
  default     = ""
  validation {
    condition     = var.private_dns_zone_name != ""
    error_message = "private_dns_zone_name cannot be empty"
  }
}

variable "virtual_network_id" {
  type        = string
  nullable    = false
  description = "Specifies the VNet ID."
  default     = ""
  validation {
    condition     = var.virtual_network_id != ""
    error_message = "virtual_network_id cannot be empty"
  }
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to be associated with the resource"
  default     = {}
}

variable "registration_enabled" {
  type        = bool
  nullable    = false
  description = "Is Private DNS zone auto registration enabled?"
  default     = true
}
