resource "azurerm_resource_group" "databricks" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_databricks_workspace" "this" {
  name                        = var.databricks_workspace_name
  location                    = azurerm_resource_group.databricks.location
  resource_group_name         = azurerm_resource_group.databricks.name
  sku                         = var.databricks_workspace_sku
  managed_resource_group_name = "${var.databricks_workspace_name}-managed"

  tags = {
    environment = "dev"
  }
  custom_parameters {
    no_public_ip                                         = true
    # storage_account_name                                 = "${replace(var.databricks_workspace_name, "/-*/", "")}storage"
    # storage_account_sku_name                             = "Standard_LRS"
    virtual_network_id                                   = var.vnet.id
    public_subnet_name                                   = azurerm_subnet.public.name
    private_subnet_name                                  = azurerm_subnet.private.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
  }
}


resource "azurerm_subnet" "private" {
  name                 = var.subnets.private.name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = var.vnet.name
  address_prefixes     = var.subnets.private.address_prefixes

  delegation {
    name = "private-databricks-del"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "public" {
  name                 = var.subnets.public.name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = var.vnet.name
  address_prefixes     = var.subnets.public.address_prefixes

  delegation {
    name = "public-databricks-del"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_security_group" "this" {
  name                = "databricks-nsg"
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
}

resource "azurerm_databricks_access_connector" "this" {
  name                = "databricks-access-connector"
  location            = azurerm_resource_group.databricks.location
  resource_group_name = azurerm_resource_group.databricks.name
  identity {
    type = "SystemAssigned"
  }
}
