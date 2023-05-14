variable "resource_group_name" {
  description = "value of the resource group name"
  type        = string
}

variable "location" {
  description = "deployment location"
  type        = string
}

variable "use_private_endpoint" {
  description = "Create a private endpoint for the storage account?"
  type        = bool
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet to use for the private endpoint"
  type        = string
}

variable "containers" {
  description = "List of container names to create in the storage account"
  type        = list(string)
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "allowed_ips" {
  description = "List of IP addresses to allow access to the storage account"
  type        = list(string)
}

variable "dns_zone_ids" {
  description = "List of DNS zone IDs to associate with the private endpoint"
  type        = list(string)
}

