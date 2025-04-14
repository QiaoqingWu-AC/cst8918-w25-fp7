output "resource_group_name" {
  description = "The name of the resource group"
  value       = var.resource_group_name
}

output "aks_test_name" {
  description = "AKS test cluster name"
  value       = module.aks_test.cluster_name
}

output "aks_prod_name" {
  description = "AKS production cluster name"
  value       = module.aks_prod.cluster_name
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = module.network.vnet_name
}

