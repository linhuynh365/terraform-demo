#############################################################################
# VARIABLES
#############################################################################

# variable "name" {
#   type        = string
#   nullable    = false
#   description = "The name of the application gateway."
#   default     = ""
#   validation {
#     condition     = var.name != ""
#     error_message = "Application gateway's name cannot be empty"
#   }
# }

# variable "resource_group_name" {
#   nullable    = false
#   description = "The name of the resource group where the resource should be created."
#   default     = ""
#   validation {
#     condition     = var.resource_group_name != ""
#     error_message = "Application gateway's resource group name cannot be empty"
#   }
# }

# variable "location" {
#   nullable    = false
#   description = "The location where this resource should be created."
#   type        = string
#   default     = "eastus"
#   validation {
#     condition     = contains(["centralus", "eastus", "eastus2"], var.location)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"centralus\", \"eastus\", \"eastus2\"."
#   }
# }

# variable "tags" {
#   description = "The tags that are to be applied to the resource."
#   nullable    = false
#   type        = map(any)
# }

# variable "sku" {
#   nullable = false
#   type     = string
#   default  = "Standard_v2"
#   validation {
#     condition     = contains(["Standard_v2", "WAF_v2"], var.sku)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Standard_v2\", \"WAF_v2\"."
#   }
# }

# variable "gateway_ip_configuration_name" {
#   description = "Gateway IP Configuration Name"
#   nullable    = false
#   type        = string
#   default     = "app_gateway_ip_config"
# }

# variable "subnet_frontend_id" {
#   description = "Subnet Frontend ID for Gateway IP Configuration"
#   nullable    = false
#   type        = string
#   default     = ""
#   validation {
#     condition     = var.subnet_frontend_id != ""
#     error_message = "Application gateway's subnet front ID cannot be empty"
#   }
# }

# variable "frontend_port_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.frontend_port_name != ""
#     error_message = "Application gateway's frontend port name cannot be empty"
#   }
# }

# variable "frontend_port_number" {
#   nullable = false
#   type     = number
#   default  = 443
# }

# variable "frontend_ip_configuration_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.frontend_ip_configuration_name != ""
#     error_message = "Application gateway's frontend IP configuration name cannot be empty"
#   }
# }

# variable "public_ip_address_id" {
#   description = "Public IP Address ID for frontend IP configuration"
#   nullable    = false
#   type        = string
#   default     = ""
#   validation {
#     condition     = var.public_ip_address_id != ""
#     error_message = "Application gateway's public IP address ID cannot be empty"
#   }
# }

# variable "backend_address_pool_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.backend_address_pool_name != ""
#     error_message = "Application gateway's backend address pool name cannot be empty"
#   }
# }

# variable "backend_address_pool_ip_adresses" {
#   nullable = true
#   type     = list(string)
#   default  = []
# }

# variable "backend_address_pool_fqdns" {
#   nullable = true
#   type     = list(string)
#   default  = []
# }

# variable "backend_http_setting_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.backend_http_setting_name != ""
#     error_message = "Application gateway's backend HTTP setting name cannot be empty"
#   }
# }

# variable "backend_http_cookie_based_affinity" {
#   nullable = true
#   type     = string
#   default  = "Disabled"
#   validation {
#     condition     = contains(["Disabled", "Enabled"], var.backend_http_cookie_based_affinity)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Disabled\", \"Enabled\"."
#   }
# }

# variable "backend_http_path" {
#   nullable = true
#   type     = string
#   default  = "/"
# }

# variable "backend_http_port" {
#   nullable = false
#   type     = number
#   default  = 443
# }

# variable "backend_http_protocol" {
#   nullable = false
#   type     = string
#   default  = "Https"
#   validation {
#     condition     = contains(["Http", "Https"], var.backend_http_protocol)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Http\", \"Https\"."
#   }
# }

# variable "backend_http_request_timeout" {
#   nullable = true
#   type     = number
#   default  = 30
# }

# variable "http_listener_name" {
#   nullable = true
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.http_listener_name != ""
#     error_message = "Application gateway's name cannot be empty"
#   }
# }

# variable "http_listener_protocol" {
#   nullable = false
#   type     = string
#   default  = "Https"
#   validation {
#     condition     = contains(["Http", "Https"], var.http_listener_protocol)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Http\", \"Https\"."
#   }
# }

# variable "request_routing_rule_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.request_routing_rule_name != ""
#     error_message = "Application gateway's request routing rule name cannot be empty"
#   }
# }

# variable "request_routing_rule_type" {
#   nullable = true
#   type     = string
#   default  = "Basic"
#   validation {
#     condition     = contains(["Basic", "PathBasedRouting"], var.request_routing_rule_type)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Basic\", \"PathBasedRouting\"."
#   }
# }

# variable "request_routing_rule_priority" {
#   nullable = true
#   type     = number
#   default  = 1
#   validation {
#     condition     = var.request_routing_rule_priority >= 1 && var.request_routing_rule_priority <= 20000
#     error_message = "Rule evaluation order can be dictated by specifying an integer value from 1 to 20000 with 1 being the highest priority and 20000 being the lowest priority."
#   }
# }

# variable "ssl_certificate_name" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.ssl_certificate_name != ""
#     error_message = "Application gateway's SSL certificate name cannot be empty"
#   }
# }

# variable "key_vault_secret_id" {
#   nullable = false
#   type     = string
#   default  = ""
#   validation {
#     condition     = var.key_vault_secret_id != ""
#     error_message = "Application gateway's key vault secret ID cannot be empty"
#   }
# }

# variable "identity_ids" {
#   nullable = false
#   type     = list(string)
#   default  = []
#   validation {
#     condition     = length(var.identity_ids) > 0
#     error_message = "Application gateway's Identity IDs cannot be empty or null"
#   }
# }

# variable "min_capacity" {
#   description = "Minimum capacity for autoscaling."
#   nullable    = false
#   type        = number
#   default     = 0
#   validation {
#     condition     = var.min_capacity >= 0 && var.min_capacity <= 100
#     error_message = "Accepted values are in the range 0 to 100."
#   }
# }

# variable "max_capacity" {
#   description = "Maximum capacity for autoscaling."
#   nullable    = false
#   type        = number
#   default     = 2
#   validation {
#     condition     = var.max_capacity >= 2 && var.max_capacity <= 125
#     error_message = "Accepted values are in the range 2 to 125."
#   }
# }

# variable "waf_configuration_enable" {
#   nullable = true
#   default  = false
#   type     = bool
# }

# variable "waf_configuration_fire_mode" {
#   nullable = true
#   default  = "Detection"
#   type     = string
#   validation {
#     condition     = contains(["Detection", "Prevention"], var.waf_configuration_fire_mode)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"Detection\", \"Prevention\"."
#   }
# }

# variable "waf_configuration_rule_set_version" {
#   nullable = true
#   default  = "0.1"
#   type     = string
#   validation {
#     condition     = contains(["0.1", "1.0", "2.2.9", "3.0", "3.1", "3.2"], var.waf_configuration_rule_set_version)
#     error_message = "The option you provided is not allowed. Please choose one of the following: \"0.1\", \"1.0\", \"2.2.9\", \"3.0\", \"3.1\", \"3.2\"."
#   }
# }
