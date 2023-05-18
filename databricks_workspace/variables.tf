variable "resource_group_name" {
  description = "Name of the resource group in which to create the Databricks workspace."
  type        = string
}

variable "location" {
  description = "Location of the resource group in which to create the Databricks workspace."
  type        = string
}

variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace."
  type        = string
}

variable "databricks_workspace_sku" {
  description = "SKU of the Databricks workspace."
  type        = string
}

variable "vnet" {
  description = "Data structure containing information about the VNet."
  type = object(
    {
      name : string,
      resource_group_name : string,
      id : string,
      location : string
    }
  )
}

variable "subnets" {
  description = "Data structure containing information about the subnets."
  type = object(
    {
      private : object({ name : string, address_prefixes : list(string) }),
      public : object({ name : string, address_prefixes : list(string) })
    }
  )
}
