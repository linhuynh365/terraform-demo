#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  type        = string
  nullable    = false
  default     = ""
  description = "The name of the traffic manager endpoint"
  validation {
    condition     = var.name != ""
    error_message = "Traffic Manager Endpoint name cannot be empty"
  }
}

variable "profile_id" {
  type        = string
  nullable    = false
  description = "The profile ID for the traffic manager profile."
  default     = ""
  validation {
    condition     = var.profile_id != ""
    error_message = "Profile ID cannot be empty"
  }
}

variable "target_resource_id" {
  nullable    = false
  type        = string
  default     = ""
  description = "The target resource id of the public IP"
  validation {
    condition     = var.target_resource_id != ""
    error_message = "Targer Resource ID name/path cannot be empty"
  }
}
