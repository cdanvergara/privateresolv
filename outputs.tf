# Output values for the Azure DNS Private Resolver deployment

output "dns_resolver_resource_group_name" {
  description = "Name of the resource group containing the DNS Private Resolver"
  value       = var.dns_resolver_resource_group_name
}

output "existing_vnet_resource_group_name" {
  description = "Name of the resource group containing the existing virtual network"
  value       = var.existing_vnet_resource_group_name
}

output "virtual_network_id" {
  description = "ID of the existing virtual network"
  value       = data.azurerm_virtual_network.example.id
}

output "virtual_network_name" {
  description = "Name of the existing virtual network"
  value       = data.azurerm_virtual_network.example.name
}

output "subnet_id" {
  description = "ID of the DNS resolver subnet"
  value       = azurerm_subnet.example.id
}

output "dns_resolver_id" {
  description = "ID of the DNS Private Resolver"
  value       = azurerm_private_dns_resolver.example.id
}

output "dns_resolver_name" {
  description = "Name of the DNS Private Resolver"
  value       = azurerm_private_dns_resolver.example.name
}

output "azure_portal_url" {
  description = "Direct link to view the DNS Private Resolver in Azure Portal"
  value       = "https://portal.azure.com/#@/resource${azurerm_private_dns_resolver.example.id}/overview"
}