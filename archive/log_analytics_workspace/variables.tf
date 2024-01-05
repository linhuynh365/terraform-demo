#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group where the resource should be created."
}

variable "location" {
  nullable    = false
  type        = string
  description = "location in Azure"
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.location)
    error_message = "The location you provided is not allowed. Choose one of the location from 'centralus or eastus or eastus2'."
  }
}

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the resource group where the resource should be created."
}

variable "retention_in_days" {
  type        = number
  nullable    = false
  description = "The workspace data retention in days."
  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "The workspace data retention in days should be between 30 and 730."
  }
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to be associated with the resource"
}
