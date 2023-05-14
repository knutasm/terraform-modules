module "storage" {
  source               = "../"
  resource_group_name  = "rg-storage-test"
  location             = "westeurope"
  storage_account_name = "storagetest"
  use_private_endpoint = true
  containers           = ["container1", "container2"]
  allowed_ips = [ "80.212.33.210" ]
  vnet_remote_state_path = "../../vnet/test/terraform.tfstate"
}
