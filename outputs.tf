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

output "inbound_subnet_id" {
  description = "ID of the DNS resolver inbound subnet"
  value       = azurerm_subnet.inbound.id
}

output "outbound_subnet_id" {
  description = "ID of the DNS resolver outbound subnet"
  value       = azurerm_subnet.outbound.id
}

output "inbound_endpoint_id" {
  description = "ID of the DNS resolver inbound endpoint"
  value       = azurerm_private_dns_resolver_inbound_endpoint.example.id
}

output "outbound_endpoint_id" {
  description = "ID of the DNS resolver outbound endpoint"
  value       = azurerm_private_dns_resolver_outbound_endpoint.example.id
}

output "inbound_endpoint_ip" {
  description = "Private IP address of the DNS resolver inbound endpoint"
  value       = azurerm_private_dns_resolver_inbound_endpoint.example.ip_configurations[0].private_ip_address
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