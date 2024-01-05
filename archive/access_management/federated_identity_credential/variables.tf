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

variable "audience" {
  description = "(Required) Specifies the audience for this Federated Identity Credential. Changing this forces a new Federated Identity Credential to be created."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "issuer" {
  description = "(Required) Specifies the issuer of this Federated Identity Credential. Changing this forces a new Federated Identity Credential to be created."
  type        = string
  nullable    = false
  default     = ""
}

variable "parent_id" {
  description = "(Required) Specifies parent ID of User Assigned Identity for this Federated Identity Credential. Changing this forces a new Federated Identity Credential to be created."
  type        = string
  nullable    = false
  default     = ""
}

variable "subject" {
  description = "(Required) Specifies the subject for this Federated Identity Credential. Changing this forces a new Federated Identity Credential to be created."
  type        = string
  nullable    = false
  default     = ""
}
