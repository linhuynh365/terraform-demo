#############################################################################
# VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group where the resource should be created."
  validation {
    condition     = var.resource_group_name != ""
    error_message = "Application Insights resource group name cannot be empty"
  }
}

variable "location" {
  nullable    = false
  type        = string
  description = "location in Azure"
  default     = "eastus"
  validation {
    condition     = contains(["centralus", "eastus", "eastus2"], var.location)
    error_message = "The location you provided is not allowed, Choose one of the location from 'centralus or eastus or eastus2'."
  }
}

variable "workspace_id" {
  type        = string
  nullable    = false
  description = "The Resource ID of the Log Analytics Workspace"
  validation {
    condition     = length(var.workspace_id) > 5
    error_message = "You must provide log analytics workspace to push app insights logs."
  }
}

variable "name" {
  type        = string
  nullable    = false
  default     = ""
  description = "Specifies the Name of Application Insights."
  validation {
    condition     = var.name != ""
    error_message = "Application Insights name cannot be empty"
  }
}

variable "application_type" {
  type        = string
  nullable    = false
  default     = "web"
  description = "Specifies the type of Application Insights to create."
  validation {
    condition     = contains(["web", "ios", "java", "Mobilecenter", "Node.JS", "phone", "store", "other"], var.application_type)
    error_message = "The type you provided is not allowed. you need to choose one of the application tyoe from 'web or ios or java or Mobilecenter or Node.js or phone or store or other'."
  }
}

variable "daily_data_cap_in_gb" {
  type        = number
  nullable    = false
  default     = 100
  description = "Specifies the Application Insights component daily data volume cap in GB."
}

variable "daily_data_cap_notification_disabled" {
  type        = bool
  nullable    = false
  default     = true
  description = "Specifies if a notification email will be send when the daily data volume cap is met."
}

variable "retention_in_days" {
  type        = number
  nullable    = false
  default     = 90
  description = " Specifies the retention period in days."
  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "The value you provided is not allowed. Choose one of the value from '30 or 60 or 90 or 120 or 180 or 270 or 365 or 550 or 730'."
  }
}

variable "sampling_percentage" {
  type        = number
  nullable    = false
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
}

variable "disable_ip_masking" {
  type        = bool
  nullable    = false
  default     = true
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. "
}

variable "tags" {
  type        = map(any)
  nullable    = false
  description = "The tags to be associated with the resource"
}
