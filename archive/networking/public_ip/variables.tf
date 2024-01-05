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
    error_message = "Public IP's resource group name cannot be empty"
  }
}

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the public IP."
  default     = ""
  validation {
    condition     = var.name != ""
    error_message = "Traffic Manager Endpoint name cannot be empty"
  }
}

variable "location" {
  nullable    = false
  description = "The location where this resource should be created."
  type        = string
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.location)
    error_message = "The option you provided is not allowed. Please choose one of the following: \"centralus\", \"eastus\", \"eastus2\"."
  }
}

variable "allocation_method" {
  type     = string
  nullable = false
  default  = "Static"
  validation {
    condition     = contains(["Static", "Dynamic"], var.allocation_method)
    error_message = "The option you provided is not allowed. Please choose one of the following: \"Static\", \"Dynamic\"."
  }
}

variable "tags" {
  description = "The tags that are to be applied to the resource."
  nullable    = false
  type        = map(any)
  default     = {}
}

variable "sku" {
  nullable = true
  default  = "Basic"
  type     = string
  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "The option you provided is not allowed. Please choose one of the following: \"Basic\", \"Standard\"."
  }
}

variable "domain_name_label" {
  type        = string
  nullable    = false
  description = "The name of the resource group we want to use."
  default     = ""
}
