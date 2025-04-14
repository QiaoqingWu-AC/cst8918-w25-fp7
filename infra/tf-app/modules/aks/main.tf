resource "azurerm_kubernetes_cluster" "aks" {
  name = var.cluster_name
  location = var.location
  resource_group_name = var.resource_group_name
  dns_prefix = "${var.cluster_name}-dns"

  default_node_pool {
    name = "default"
    vm_size = "Standard_B2s"
    node_count = var.node_count
    min_count = var.min_count
    max_count = var.max_count
    enable_auto_scaling = var.enable_auto_scaling
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.32.0"
}