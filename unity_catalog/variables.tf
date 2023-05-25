variable "storage_account" {
  description = "Storage account to use for the catalog"
  type = object({
    name = string
    id = string
  })
}
  
variable "databricks_workspace_ids" {
  description = "IDs of the databricks workspaces to assign to the catalog"
  type = map(number)
}

variable "databricks_host" {
  description = "Host of the databricks workspace"
  type = string
}

variable "databricks_location" {
  description = "Location of the databricks workspace"
  type = string
}
  
variable "databricks_resource_group_name" {
  description = "Resource group of the databricks workspace"
  type = string
}
  