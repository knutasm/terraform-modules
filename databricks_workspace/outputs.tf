output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.this.id
}
  
output "databricks_host" {
  value = azurerm_databricks_workspace.this.workspace_url
}