# Input variables for the Azure DNS Private Resolver configuration

variable "existing_vnet_name" {
  type        = string
  description = "Name of the existing virtual network where the DNS resolver will be deployed"
}

variable "existing_vnet_resource_group_name" {
  type        = string
  description = "Name of the resource group containing the existing virtual network"
}

variable "dns_resolver_name" {
  type        = string
  default     = "dns-private-resolver"
  description = "Name of the DNS Private Resolver"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.dns_resolver_name))
    error_message = "DNS resolver name can only contain alphanumeric characters and hyphens."
  }
}

variable "dns_resolver_resource_group_name" {
  type        = string
  description = "Name of the resource group where the DNS Private Resolver will be created"
}

variable "dns_resolver_inbound_subnet_name" {
  type        = string
  default     = "snet-dns-resolver-inbound"
  description = "Name of the inbound subnet for the DNS Private Resolver"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.dns_resolver_inbound_subnet_name))
    error_message = "Subnet name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "dns_resolver_inbound_subnet_address_prefix" {
  type        = string
  default     = "10.0.1.0/28"
  description = "Address prefix for the DNS resolver inbound subnet (must be at least /28)"
  
  validation {
    condition     = can(cidrhost(var.dns_resolver_inbound_subnet_address_prefix, 0))
    error_message = "Subnet address prefix must be a valid CIDR notation."
  }
}

variable "dns_resolver_outbound_subnet_name" {
  type        = string
  default     = "snet-dns-resolver-outbound"
  description = "Name of the outbound subnet for the DNS Private Resolver"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.dns_resolver_outbound_subnet_name))
    error_message = "Subnet name can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "dns_resolver_outbound_subnet_address_prefix" {
  type        = string
  default     = "10.0.2.0/28"
  description = "Address prefix for the DNS resolver outbound subnet (must be at least /28)"
  
  validation {
    condition     = can(cidrhost(var.dns_resolver_outbound_subnet_address_prefix, 0))
    error_message = "Subnet address prefix must be a valid CIDR notation."
  }
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location where the DNS Private Resolver will be created"
  
  validation {
    condition = contains([
      "eastus", "eastus2", "westus", "westus2", "westus3", "centralus",
      "northcentralus", "southcentralus", "westcentralus",
      "northeurope", "westeurope", "uksouth", "ukwest",
      "francecentral", "germanywestcentral", "switzerlandnorth",
      "norwayeast", "swedencentral"
    ], var.resource_group_location)
    error_message = "The resource group location must be a valid Azure region that supports DNS Private Resolver."
  }
}



variable "environment_tag" {
  type        = string
  default     = "Development"
  description = "Environment tag for resources (e.g., Development, Staging, Production)"
  
  validation {
    condition     = contains(["Development", "Staging", "Production", "Testing"], var.environment_tag)
    error_message = "Environment tag must be one of: Development, Staging, Production, Testing."
  }
}