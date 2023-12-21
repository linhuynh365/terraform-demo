# #############################################################################
# # REQUIRED PROVIDER
# #############################################################################

# #  terraform {
# #    required_providers {
# #      azurerm = {
# #        source  = "hashicorp/azurerm"
# #      }
# #    }
# #    required_version = ">= 0.14.9"
# #  }


# # provider "azurerm" {
# #   features {}
# # }

# #############################################################################
# # RESOURCES
# #############################################################################

# resource "azurerm_application_gateway" "app_gateway" {
#   name                = var.name
#   resource_group_name = var.resource_group_name
#   location            = var.location

#   # Standard_v2 is the only option left because Standard is deprecated and WAF setting is not desirable
#   sku {
#     name = var.sku
#     tier = var.sku
#   }

#   tags = merge(var.tags, { "created_by" = "dep_terraform", "type" = "application_gateway" })

#   gateway_ip_configuration {
#     name      = var.gateway_ip_configuration_name
#     subnet_id = var.subnet_frontend_id
#   }

#   frontend_port {
#     name = var.frontend_port_name
#     port = var.frontend_port_number
#   }

#   frontend_ip_configuration {
#     name                 = var.frontend_ip_configuration_name
#     public_ip_address_id = var.public_ip_address_id
#   }

#   backend_address_pool {
#     name         = var.backend_address_pool_name
#     ip_addresses = var.backend_address_pool_ip_adresses
#     fqdns        = var.backend_address_pool_fqdns
#   }

#   backend_http_settings {
#     name                  = var.backend_http_setting_name
#     cookie_based_affinity = var.backend_http_cookie_based_affinity
#     path                  = var.backend_http_path
#     port                  = var.backend_http_port
#     protocol              = var.backend_http_protocol
#     request_timeout       = var.backend_http_request_timeout
#   }

#   http_listener {
#     name                           = var.http_listener_name
#     frontend_ip_configuration_name = var.frontend_ip_configuration_name
#     frontend_port_name             = var.frontend_port_name
#     protocol                       = var.http_listener_protocol
#     ssl_certificate_name           = var.ssl_certificate_name
#   }

#   request_routing_rule {
#     name                       = var.request_routing_rule_name
#     rule_type                  = var.request_routing_rule_type
#     priority                   = var.request_routing_rule_priority
#     http_listener_name         = var.http_listener_name
#     backend_address_pool_name  = var.backend_address_pool_name
#     backend_http_settings_name = var.backend_http_setting_name
#   }

#   autoscale_configuration {
#     min_capacity = var.min_capacity
#     max_capacity = var.max_capacity
#   }

#   ssl_certificate {
#     name                = var.ssl_certificate_name
#     key_vault_secret_id = var.key_vault_secret_id
#   }

#   identity {
#     type         = "UserAssigned"
#     identity_ids = var.identity_ids
#   }
# }
