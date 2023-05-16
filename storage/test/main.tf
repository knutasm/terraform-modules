data "terraform_remote_state" "vnet" {
  backend = "local"

  config = {
    path = "../../vnet/test/terraform.tfstate"
  }
}


module "storage" {
  source               = "../"
  resource_group_name  = "rg-storage-test"
  location             = "westeurope"
  storage_account_name = "storagetest"
  use_private_endpoint = true
  containers           = ["container1", "container2"]
  allowed_ips = [ "80.212.33.210" ]
  private_endpoint_subnet_id = data.terraform_remote_state.vnet.outputs.snet.default
  dns_zone_ids = [ data.terraform_remote_state.vnet.outputs.blob_dns_zone_id ]
}

output "storage_account_name" {
  description = "The name of the resource"
  value = module.storage.storage_account_name
}
  
output "storage_account_id" {
  description = "The ID of the resource"
  value = module.storage.storage_account_id
}