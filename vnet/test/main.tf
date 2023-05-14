module "vnet" {
  source = "../"
  resource_group_name = "rg-vnet-test"
  location = "westeurope"
  vnet_name = "vnet-test"
  vnet_cidr_range = "192.168.0.0/20"
  subnets = {
    "default" = "192.168.0.0/24",
    "public"  = "192.168.1.0/24"
  }
}

output "snet" {
  value = module.vnet.subnet_ids
}

output "resource_group_name" {
  value = module.vnet.resource_group_name
}
