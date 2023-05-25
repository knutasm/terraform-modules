terraform {
  required_providers {

    databricks = {
      source = "databricks/databricks"
    }
  }
}

data "terraform_remote_state" "databricks" {
  backend = "local"
  config = {
    path = "../../databricks_workspace/test/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage" {
  backend = "local"
  config = {
    path = "../../storage/test/terraform.tfstate"
  }
}

provider "databricks" {
  host = data.terraform_remote_state.databricks.outputs.databricks_host
}

provider "azurerm" {
    features {}
}

module "unity_catalog" {
  source = "../"
  databricks_location = data.terraform_remote_state.databricks.outputs.databricks_location
  databricks_resource_group_name = data.terraform_remote_state.databricks.outputs.databricks_resource_group_name
  storage_account = {
    name = data.terraform_remote_state.storage.outputs.storage_account_name
    id   = data.terraform_remote_state.storage.outputs.storage_account_id
  }
  databricks_workspace_ids = {
    id = data.terraform_remote_state.databricks.outputs.databricks_workspace_id
  }
  databricks_host = data.terraform_remote_state.databricks.outputs.databricks_host
}
