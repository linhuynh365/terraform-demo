#############################################################################
# VARIABLES
#############################################################################

variable "scope" {
  type        = string
  nullable    = false
  description = "The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333."
}

variable "role_definition_name" {
  type        = string
  nullable    = false
  description = "The role to be assigned to the accessor."
}

variable "principal_id" {
  description = "The principal/object id of the user/group/app that needs to be given access."
  nullable    = false
  type        = string
}
