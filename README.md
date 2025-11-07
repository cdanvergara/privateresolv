# Azure DNS Private Resolver Terraform Project

This Terraform configuration creates an Azure DNS Private Resolver with all required networking components according to Microsoft Azure best practices.

## What This Configuration Creates

- **DNS Private Resolver**: The main resolver service in your existing virtual network
- **Inbound Subnet**: A dedicated subnet for inbound DNS queries with proper delegation to Microsoft.Network/dnsResolvers
- **Outbound Subnet**: A dedicated subnet for outbound DNS queries with proper delegation to Microsoft.Network/dnsResolvers
- **Inbound Endpoint**: Handles DNS queries coming into your virtual network
- **Outbound Endpoint**: Handles DNS queries going out from your virtual network
- Uses your existing VNet and resource group infrastructure

## Prerequisites

1. **Azure CLI**: Ensure you have Azure CLI installed and are logged in
   ```powershell
   az login
   az account set --subscription "your-subscription-id"
   ```

2. **Terraform**: Install Terraform if not already installed
   ```powershell
   winget install Hashicorp.Terraform
   ```

3. **Azure Subscription**: You need an active Azure subscription with appropriate permissions to create resources

## Quick Start

1. **Clone or download this configuration**
   ```powershell
   cd c:\GH\dnsresolv
   ```

2. **Configure your existing infrastructure details**
   ```powershell
   Copy-Item terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your existing VNet and resource group details
   ```

3. **Initialize Terraform**
   ```powershell
   terraform init -upgrade
   ```

4. **Validate the configuration**
   ```powershell
   terraform validate
   ```

5. **Plan the deployment**
   ```powershell
   terraform plan -out main.tfplan
   ```

6. **Apply the configuration**
   ```powershell
   terraform apply main.tfplan
   ```

## Configuration Files

- `main.tf` - Main resource definitions
- `providers.tf` - Terraform and provider version constraints
- `variables.tf` - Input variables with validation
- `outputs.tf` - Output values after deployment
- `terraform.tfvars.example` - Example variable values

## Customization

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `existing_vnet_name` | Name of existing virtual network | - | Yes |
| `existing_vnet_resource_group_name` | Resource group of existing VNet | - | Yes |
| `dns_resolver_name` | Name of DNS Private Resolver | dns-private-resolver | No |
| `dns_resolver_resource_group_name` | Resource group for DNS resolver | - | Yes |
| `dns_resolver_inbound_subnet_name` | Name of DNS resolver inbound subnet | snet-dns-resolver-inbound | No |
| `dns_resolver_inbound_subnet_address_prefix` | Subnet CIDR for inbound endpoint | 10.0.1.0/28 | No |
| `dns_resolver_outbound_subnet_name` | Name of DNS resolver outbound subnet | snet-dns-resolver-outbound | No |
| `dns_resolver_outbound_subnet_address_prefix` | Subnet CIDR for outbound endpoint | 10.0.2.0/28 | No |
| `resource_group_location` | Azure region for DNS resolver | eastus | No |
| `environment_tag` | Environment tag for resources | Development | No |

### Supported Regions

The configuration validates that you're using a region that supports DNS Private Resolver:
- East US, East US 2, West US, West US 2, West US 3
- Central US, North Central US, South Central US, West Central US
- North Europe, West Europe, UK South, UK West
- France Central, Germany West Central, Switzerland North
- Norway East, Sweden Central

## Security Features

- Uses managed identity authentication (when run from Azure services)
- No hardcoded credentials
- Proper subnet delegation for security
- Resource tagging for governance
- Input validation for all variables

## After Deployment

After successful deployment, you'll receive:
- Resource group name and location
- Virtual network and subnet IDs
- DNS resolver ID and name
- Direct Azure Portal link to view your resolver

## Verification

Verify your deployment using Azure CLI:

```powershell
# Get the resource group name from Terraform output
$dnsResolverRgName = terraform output -raw dns_resolver_resource_group_name
$dnsResolverName = terraform output -raw dns_resolver_name

# List all resources in the DNS resolver resource group
az resource list --resource-group $dnsResolverRgName --output table

# View the DNS Private Resolver
az network private-dns resolver show --name $dnsResolverName --resource-group $dnsResolverRgName

# View the created subnet in the existing VNet
$vnetName = terraform output -raw virtual_network_name
$vnetRgName = terraform output -raw existing_vnet_resource_group_name
az network vnet subnet show --name "snet-dns-resolver" --vnet-name $vnetName --resource-group $vnetRgName
```

## Clean Up

To remove all created resources:

```powershell
terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Ensure you're logged into Azure CLI with `az login`
2. **Region Not Supported**: Check that your chosen region supports DNS Private Resolver
3. **Subnet Size**: The /28 subnet provides 16 IP addresses (11 usable for Azure services)
4. **Resource Naming**: Resource group names must be unique within your subscription

### Getting Help

- [Azure DNS Private Resolver Documentation](https://docs.microsoft.com/en-us/azure/dns/dns-private-resolver-overview)
- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Reference](https://docs.microsoft.com/en-us/cli/azure/)

## Architecture

```
┌─────────────────────────────────────────────┐
│ Existing VNet Resource Group                │
│ ┌─────────────────────────────────────────┐ │
│ │ Existing Virtual Network               │ │
│ │ ┌─────────────────────────────────────┐ │ │
│ │ │ New DNS Resolver Subnet (/28)      │ │ │
│ │ │ - Delegated to DNS Resolvers        │ │ │
│ │ └─────────────────────────────────────┘ │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
┌─────────────────────────────────────────────┐
│ DNS Resolver Resource Group                 │
│ ┌─────────────────────────────────────────┐ │
│ │ DNS Private Resolver                    │ │
│ │ - Associated with existing VNet         │ │
│ └─────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

## License

This configuration is provided as-is for educational and production use. Modify as needed for your specific requirements.