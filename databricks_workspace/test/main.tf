data "terraform_remote_state" "vnet" {
  backend = "local"

  config = {
    path = "../../vnet/test/terraform.tfstate"
  }
}

module "datbricks" {
  source                    = "../"
  resource_group_name       = "rg-databricks-test"
  location                  = "westeurope"
  databricks_workspace_name = "databricks-test"
  databricks_workspace_sku  = "premium"
  vnet = {
    name                = data.terraform_remote_state.vnet.outputs.vnet_name
    resource_group_name = data.terraform_remote_state.vnet.outputs.resource_group_name
    id                  = data.terraform_remote_state.vnet.outputs.vnet_id
    location            = data.terraform_remote_state.vnet.outputs.location
  }
  subnets = {
    private = {
      name             = "databricks-private"
      address_prefixes = ["192.168.2.0/24"]
    }
    public = {
      name             = "databricks-public"
      address_prefixes = ["192.168.3.0/24"]
    }
  }
}

output "databricks_workspace_id" {
  value = module.datbricks.databricks_workspace_id
}

output "databricks_host" {
  value = module.datbricks.databricks_host
}

output "databricks_resource_group_name" {
  value = module.datbricks.databricks_resource_group_name
}

output "databricks_location" {
  value = module.datbricks.databricks_location
}
