#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The resource group name where the public IP exists."
  nullable    = false
  validation {
    condition     = var.resource_group_name != ""
    error_message = "Public IP's resource group name cannot be empty"
  }
}

variable "name" {
  type        = string
  default     = ""
  description = "Public IP's name."
  nullable    = false
  validation {
    condition     = var.name != ""
    error_message = "Public IP's name cannot be empty"
  }
}
