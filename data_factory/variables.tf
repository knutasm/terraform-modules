variable "resource_group_name" {
  description = "value of the resource group name"
  type = string
}
  
variable "location" {
  description = "value of the location"
    type = string
}

variable "data_factory_name" {
  description = "value of the data factory name"
  type = string
}

variable "managed_private_endoints" {
  description = "Mapping of endpoint name to resource id"
  type = map(map(string))
}

variable "azure_integration_runtime" {
  description = "Integration runtime configuration"
  type = map(string)
}