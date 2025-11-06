# Azure DNS Private Resolver Terraform Configuration
# This configuration creates an Azure DNS Private Resolver with required networking components

# Reference existing resource group for the DNS Private Resolver
data "azurerm_resource_group" "dns_resolver_rg" {
  name = var.dns_resolver_resource_group_name
}

# Reference the existing virtual network for the DNS Private Resolver
data "azurerm_virtual_network" "example" {
  name                = var.existing_vnet_name
  resource_group_name = var.existing_vnet_resource_group_name
}

# Create a dedicated subnet for the DNS Private Resolver
# This subnet requires delegation to Microsoft.Network/dnsResolvers
resource "azurerm_subnet" "example" {
  name                 = var.dns_resolver_subnet_name
  resource_group_name  = var.existing_vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.example.name
  address_prefixes     = [var.dns_resolver_subnet_address_prefix]

  # Required delegation for DNS Private Resolver
  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

# Create the Azure DNS Private Resolver
resource "azurerm_private_dns_resolver" "example" {
  name                = var.dns_resolver_name
  resource_group_name = var.dns_resolver_resource_group_name
  location            = var.resource_group_location
  virtual_network_id  = data.azurerm_virtual_network.example.id

  tags = {
    Environment = var.environment_tag
    Project     = "DNS-Private-Resolver"
    CreatedBy   = "Terraform"
  }
}