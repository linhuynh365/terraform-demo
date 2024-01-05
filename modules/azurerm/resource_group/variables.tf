#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the resource group."
}

variable "location" {
  nullable    = false
  description = "The location where this resource should be created."
  type        = string
  # validation {
  #   condition     = contains(["centralus", "eastus", "eastus2"], var.location)
  #   error_message = "The location you provided is not alowed."
  # }
}
