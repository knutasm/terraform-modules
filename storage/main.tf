resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}


resource "random_integer" "storage" {
  min = 1000
  max = 9999
  keepers = {
    resource_group_name = var.resource_group_name
  }
}
resource "azurerm_storage_account" "storage" {
  name                          = "${var.storage_account_name}${random_integer.storage.result}"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.allowed_ips
  }
}

data "terraform_remote_state" "vnet" {
  backend = "local"

  config = {
    path = "../../vnet/test/terraform.tfstate"
  }
}

resource "azurerm_private_endpoint" "name" {
  count = var.use_private_endpoint ? 1 : 0

  name                = "pe-${azurerm_storage_account.storage.name}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = data.terraform_remote_state.vnet.outputs.snet.value.public

  private_service_connection {
    name                           = "private-endpoint-connection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = [for container in var.containers : container]
    is_manual_connection           = false
  }
}

resource "azurerm_storage_container" "this" {
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"

  for_each = toset(var.containers)
  name     = each.value
}

