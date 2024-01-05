#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group we want to use"
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to associate the resource we are creating"
}

variable "name" {
  type        = string
  nullable    = false
  description = "Name of the vnet to create"
}

variable "location" {
  nullable    = false
  description = "Resouce Group Region."
  type        = string
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.location)
    error_message = "The location you provided is not alowed. Choose one of the location from 'centralus or eastus or eastus2'."
  }
}
