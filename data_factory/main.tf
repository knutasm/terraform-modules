resource "azurerm_resource_group" "this" {
  location = var.location
  name     = var.resource_group_name  
}

resource "azurerm_data_factory" "this" {
    name                = var.data_factory_name
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    public_network_enabled = false
    managed_virtual_network_enabled = true
    identity {
        type = "SystemAssigned"
    }
}