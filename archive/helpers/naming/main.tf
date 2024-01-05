#############################################################################
# REQUIRED PROVIDER
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.50.0"
#     }
#   }
#   required_version = "1.4.6"
# }

#############################################################################
# RESOURCES
#############################################################################

module "naming" {
  source = "Azure/naming/azurerm"
  prefix = [local.first_prefix, var.division_code, var.business_unit_code]
  suffix = [local.first_suffix, local.second_suffix]
  # unique-include-numbers = var.unique-include-numbers
  # unique-length = var.unique-length
  # unique-seed =  var.unique-seed
}

locals {
  first_prefix = format(
    "%s%s%s",
    var.cloud_code,
    var.country_code,
    var.region_code != null ? var.region_code : ""
  )
  first_suffix = format(
    "%s%s",
    var.environment_code != null ? var.environment_code : "",
    var.environment_number != null ? var.environment_number : ""
  )
  second_suffix = format(
    "%s%s",
    var.app_name_code != null ? var.app_name_code : "",
    var.app_suffix_number != null ? var.app_suffix_number : ""
  )
}
