output "vnet_id" {
  description = "ID of the virtual network resource"
  value       = azurerm_virtual_network.this.id
}

output "resource_group_name" {
  description = "Name of the resource group of the vnet"
  value = azurerm_resource_group.this.name
}


output "subnet_ids" {
  value = tomap({
    for name, subnet in azurerm_subnet.this : name => subnet.id
  })
}