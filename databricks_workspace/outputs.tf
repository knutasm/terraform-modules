output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.this.workspace_id
}
  
output "databricks_host" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "databricks_resource_group_name" {
  value = azurerm_databricks_workspace.this.resource_group_name
}

output "databricks_location" {
  value = azurerm_databricks_workspace.this.location
}

