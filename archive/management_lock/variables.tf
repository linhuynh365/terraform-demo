#############################################################################
# VARIABLES
#############################################################################

variable "lock_name" {
  type        = string
  description = "Name of the lock"
  nullable    = false
}

variable "lock_level" {
  type        = string
  description = "The level at which the lock should be applied"
  nullable    = false
  default     = "CanNotDelete"
}

variable "scope" {
  description = "The scope of the lock."
  type        = string
  nullable    = false
}

variable "notes" {
  description = "The reason this lock is created."
  type        = string
  nullable    = true
}
