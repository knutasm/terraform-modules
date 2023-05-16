data "terraform_remote_state" "storage" {
  backend = "local"

  config = {
    path = "../../storage/test/terraform.tfstate"
  }
}


module "data_factory" {
  source              = "../"
  resource_group_name = "rg-data-factory-test"
  location            = "westeurope"
  data_factory_name   = "test-data-factory-knutasm"
  azure_integration_runtime = {
    "name"        = "test-azure-integration-runtime-knutasm",
    "description" = "Vnet injected ingegration runtime",
  }

  managed_private_endoints = {
    "storage-landing" = {
      "resource"    = data.terraform_remote_state.storage.outputs.storage_account_id,
      "subresource" = "blob"
    }
  }
}
