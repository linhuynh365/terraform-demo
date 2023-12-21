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
  description = "Specifies the Name of Private DNS Zone.It should include atleast two labels"
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to be associated with the resource"
  default     = {}
}