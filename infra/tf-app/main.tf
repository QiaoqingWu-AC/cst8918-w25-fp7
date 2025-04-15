terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      configuration_aliases = [
        kubernetes.test,
        kubernetes.prod
      ]
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

provider "kubernetes" {
  alias                  = "test"
  host                   = module.aks_test.host
  client_certificate     = base64decode(module.aks_test.client_certificate)
  client_key             = base64decode(module.aks_test.client_key)
  cluster_ca_certificate = base64decode(module.aks_test.cluster_ca_certificate)
}

provider "kubernetes" {
  alias                  = "prod"
  host                   = module.aks_prod.host
  client_certificate     = base64decode(module.aks_prod.client_certificate)
  client_key             = base64decode(module.aks_prod.client_key)
  cluster_ca_certificate = base64decode(module.aks_prod.cluster_ca_certificate)
}

resource "azurerm_resource_group" "project_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on = [azurerm_resource_group.project_rg]
}

module "aks_test" {
  source              = "./modules/aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on          = [azurerm_resource_group.project_rg]

  cluster_name        = "aks-test"
  node_count          = 1
  min_count           = 1
  max_count           = 1
  enable_auto_scaling = true
}

module "aks_prod" {
  source              = "./modules/aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on          = [azurerm_resource_group.project_rg]

  cluster_name        = "aks-prod"
  node_count          = 1
  min_count           = 1
  max_count           = 3
  enable_auto_scaling = true
}

module "remix_app" {
  source = "./modules/remix-app"

  providers = {
    kubernetes.test = kubernetes.test
    kubernetes.prod = kubernetes.prod
  }

  image_tag           = var.image_tag
  acr_login_server    = module.remix_app.acr_login_server
  test_redis_hostname = module.remix_app.redis_test_hostname
  test_redis_key      = module.remix_app.redis_test_primary_key
  prod_redis_hostname = module.remix_app.redis_prod_hostname
  prod_redis_key      = module.remix_app.redis_prod_primary_key

  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on = [
    module.aks_test,
    module.aks_prod
  ]
}
