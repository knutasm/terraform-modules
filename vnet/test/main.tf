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

output "blob_dns_zone_id" {
  value = module.vnet.blob_dns_zone_id
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "location" {
  value = module.vnet.location
}