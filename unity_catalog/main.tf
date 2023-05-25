resource "azurerm_databricks_access_connector" "this" {
  name                = "databricks-access-connector"
  location            = var.databricks_location
  resource_group_name = var.databricks_resource_group_name
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "unity_catalog" {
  name                  = "unity-catalog"
  storage_account_name  = var.storage_account.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "uc_storage" {
  scope                = var.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.this.identity[0].principal_id
}

resource "databricks_metastore" "primary" {
  name = "primary"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    azurerm_storage_container.unity_catalog.name,
    var.storage_account.name
  )
}

resource "databricks_metastore_data_access" "this" {
  metastore_id = databricks_metastore.primary.id
  name         = "metastore-access-id"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.this.id
  }
  is_default = true
}

resource "databricks_metastore_assignment" "this" {
  metastore_id         = databricks_metastore.primary.id

  for_each = var.databricks_workspace_ids
  workspace_id         = each.value
  default_catalog_name = "hive_metastore"
}
