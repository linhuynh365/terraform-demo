#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The resource group name where the AKS exists."
  nullable    = false
  validation {
    condition     = var.resource_group_name != ""
    error_message = "AKS's resource group name cannot be empty"
  }
}

variable "name" {
  type        = string
  default     = ""
  description = "AKS's name."
  nullable    = false
  validation {
    condition     = var.name != ""
    error_message = "AKS's name cannot be empty"
  }
}
