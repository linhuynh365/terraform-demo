#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  description = "(Required) Specifies the name of Identity"
  type        = string
  nullable    = false
  default     = ""
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group."
  type        = string
  nullable    = false
  default     = ""
}

variable "location" {
  description = "(Required) Specifies the location where resource to be created."
  type        = string
  nullable    = false
  default     = ""
}

variable "tags" {
  description = "(Optional) Specifies the tags of the bastion host"
  default     = {}
}
