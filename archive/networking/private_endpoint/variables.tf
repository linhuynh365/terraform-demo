#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  description = "The name of the private endpoint."
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location for the resource group."
  type        = string
  nullable    = false
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
  nullable    = false
}

variable "private_connection_name" {
  description = "The name of the private connection."
  type        = string
  nullable    = false
}

variable "private_resource_id" {
  description = "The resource ID of the private resource being accessed."
  type        = string
  nullable    = false
}

variable "subresource_name" {
  description = "The names of the subresource to be accessed."
  type        = string
  nullable    = false
}

variable "is_manual_connection" {
  description = "The manual approval from the remote resource owner"
  type        = bool
  default     = false
  nullable    = true
}

variable "private_dns_zone_group_name" {
  description = "The name of private DNS zone group"
  type        = string
  nullable    = false
}

variable "private_dns_zone_ids" {
  description = "The id of private DNS zone"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to be associated with the resource"
  default     = {}
}
