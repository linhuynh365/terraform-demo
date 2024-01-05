#############################################################################
# VARIABLES
#############################################################################

variable "tenant_id" {
  type        = string
  description = "Needed to access the tenant."
  nullable    = false
  default     = "8ac76c91-e7f1-41ff-a89c-3553b2da2c17"
}

variable "subscription_id" {
  type        = string
  description = "Needed to access the subscription."
  nullable    = false
  default     = "535d8700-ff37-4ffe-85fc-7d2ba7352a66"
}

variable "client_id" {
  type        = string
  description = "Needed to access the client."
  nullable    = false
  default     = "8325f696-03bb-4d3c-acf6-85ea996dc863"
}

variable "resource_group_name" {
  type        = string
  default     = "zuse1-taa-dxg-rg-p1-depdata1"
  description = "The resource group name where storage account exists."
  nullable    = false
}

variable "storage_account_name" {
  type        = string
  default     = "zuse1taadxgstp1depdata1"
  description = "The storage account where remote state is stored."
  nullable    = false
}

variable "container_name" {
  type        = string
  default     = "zuse1-taa-dxg-stct-p1-depdata1"
  description = "The storage account container where remote state is stored."
  nullable    = false
}

variable "key" {
  type        = string
  description = "The file name of terraform state."
  nullable    = false
}

variable "environment" {
  type        = string
  description = "The environment."
  nullable    = false
}
