resource "azurerm_resource_group" "this" {
  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_data_factory" "this" {
  name                            = var.data_factory_name
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  public_network_enabled          = false
  managed_virtual_network_enabled = true
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "this" {
  data_factory_id = azurerm_data_factory.this.id
  for_each        = var.managed_private_endoints

  name               = each.key
  target_resource_id = each.value.resource
  subresource_name   = each.value.subresource
}


resource "azurerm_data_factory_integration_runtime_azure" "this" {
  name            = var.azure_integration_runtime.name
  description     = var.azure_integration_runtime.description
  data_factory_id = azurerm_data_factory.this.id
  location        = azurerm_data_factory.this.location
  virtual_network_enabled = true
}
