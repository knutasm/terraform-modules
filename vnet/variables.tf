variable "location" {
  description = "Deployment region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string

}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_cidr_range" {
  description = "IP range of the vnet"
  type        = string
}

variable "subnets" {
  description = "Map of subnets for the vnet"
  type        = map(string)
}
