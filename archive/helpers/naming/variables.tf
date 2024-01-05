#############################################################################
# VARIABLES
#############################################################################


variable "cloud_code" {
  type        = string
  description = "The code assigned for cloud environment."
  nullable    = false
}

variable "country_code" {
  type        = string
  description = "The country code to be used for the resource"
  nullable    = false
}

variable "region_code" {
  type        = number
  description = "The region code to be used for the resource."
  nullable    = false
}

variable "division_code" {
  type        = string
  description = "The division code to be used for the environment."
  nullable    = false
}

variable "business_unit_code" {
  type        = string
  description = "The business unit code to be used for the environment."
  nullable    = false
}

# variable "prefix" {
#   default     = [format(var.cloud_code, var.country_code, var.region_code), var.division_code, var.business_unit_code]
#   type        = list(string)
#   description = "It is not recommended that you use prefix by azure you should be using a suffix for your resources."
#   nullable    = false
# }

# variable "sub_resource_name_code" {
#   type        = string
#   description = "The sub resouce name code to be used for the environment."
#   nullable    = true
# }

variable "environment_code" {
  type        = string
  description = "The environment code to be used for the environment."
  nullable    = false
}

variable "environment_number" {
  type        = number
  default     = null
  description = "The environment number to be used for the environment."
  nullable    = true
}

variable "app_name_code" {
  type        = string
  description = "The application name code to be used for the environment."
  nullable    = false
}

variable "app_suffix_number" {
  type        = number
  default     = null
  description = "The sub resouce name code to be used for the environment."
  nullable    = true
}

# variable "suffix" {
#   default     = [var.sub_resource_name_code, format(var.environment_code, var.environment_number)]
#   type        = list(string)
#   description = "It is recommended that you specify a suffix for consistency. please use only lowercase characters when possible."
#   nullable    = false
# }

# variable "unique-include-numbers" {
#   type    = bool
#   default = false
#   description = "If you want to include numbers in the unique generation."
#   nullable = false
# }

# variable "unique-length" {
#   type = number
#   default = 0
#   description = "Max length of the uniqueness suffix to be added."
#   nullable = false
# }

# variable "unique-seed" {
#   type = string
#   default = ""
#   description = "Custom value for the random characters to be used."
#   nullable = true
# }
