#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  description = "The name of the container."
  nullable    = false
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account where the container is supposed to be created."
  nullable    = false
  type        = string
}

variable "container_access_type" {
  description = "The access type of container to be created."
  default     = "private"
  nullable    = false
  type        = string
  validation {
    condition     = contains(["blob", "container", "private"], var.container_access_type)
    error_message = "The type you provided is not alowed. You need to choose container access type value from 'blob or container or private'."
  }
}
