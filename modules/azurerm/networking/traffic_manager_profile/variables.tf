#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the traffic manager profile"
  default     = ""
  validation {
    condition     = var.name != ""
    error_message = "Traffic manager profile's name cannot be empty"
  }
}

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group where the resource should be created."
  default     = ""
  validation {
    condition     = var.resource_group_name != ""
    error_message = "Traffic manager profile's resource group name cannot be empty"
  }
}

variable "traffic_routing_method" {
  nullable    = false
  type        = string
  description = "The routing method of traffic manager in azure"
  default     = "Performance"
  validation {
    condition     = contains(["Weighted", "Performance"], var.traffic_routing_method)
    error_message = "The traffic routing method you provided is not recommended. you need to choose one of traffic routing method from 'Weighted or Performance'."
  }
}

variable "relative_name" {
  nullable    = false
  type        = string
  description = "The relative name of DNS"
  default     = ""
  validation {
    condition     = var.relative_name != ""
    error_message = "Traffic manager profile's relative name cannot be empty"
  }
}

variable "ttl" {
  nullable    = false
  type        = number
  default     = 50
  description = "The ttl for DNS resolver in azure"
}

variable "protocol" {
  nullable    = false
  type        = string
  default     = "HTTPS"
  description = "The protocol part of monitor traffic"
}

variable "port" {
  nullable    = false
  type        = number
  default     = 443
  description = "The port is part monitor config"
}

variable "tags" {
  nullable    = false
  type        = map(any)
  description = "The tags that are to be applied to the resource."
}

variable "path" {
  nullable    = false
  type        = string
  default     = "/"
  description = "The path is part of monitor config"
}
