#############################################################################
# VARIABLES
#############################################################################

variable "name" {
  description = "The account name for cosmosdb"
  type        = string
  nullable    = false
}

variable "location" {
  description = "Azure region where the Azure Cosmos DB account will be created"
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  nullable    = false
}

variable "offer_type" {
  description = "Offer type for cosmosdb"
  type        = string
  nullable    = false
}

variable "kind" {
  description = "The kind for cosmosdb"
  type        = string
  nullable    = false
}

variable "failover_priority" {
  description = "The failover priority for cosmosdb"
  type        = number
  nullable    = false
  default     = 0
}

variable "consistency_level" {
  description = "The level for consistency policy"
  type        = string
  nullable    = false
}

variable "database_name" {
  description = "The name of the database to be created."
  type        = string
  nullable    = false
}

variable "throughput" {
  type        = number
  default     = 400
  description = "Cosmos db database throughput"
  validation {
    condition     = var.throughput >= 400 && var.throughput <= 1000000
    error_message = "Cosmos db manual throughput should be equal to or greater than 400 and less than or equal to 1000000."
  }
  validation {
    condition     = var.throughput % 100 == 0
    error_message = "Cosmos db throughput should be in increments of 100."
  }
}

variable "database_container_name" {
  description = "The name of the database container to be created."
  type        = string
  nullable    = false
}

variable "indexing_mode" {
  description = "The indexing mode for the container"
  type        = string
  nullable    = false
  default     = "consistent"
}

variable "ip_range_filter" {
  description = "CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IPs for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces."
  type        = string
  nullable    = true
  default     = ""
}

variable "tags" {
  nullable    = false
  type        = map(any)
  description = "The tags that are to be applied to the resource."
}
