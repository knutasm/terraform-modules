output "storage_account_name" {
  description = "The name of the resource"
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  description = "The ID of the resource"
  value = azurerm_storage_account.storage.id
}
