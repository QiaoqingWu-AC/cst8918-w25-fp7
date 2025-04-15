# Container registry to store weather app docker image
resource "azurerm_container_registry" "acrgroup7" {
  name                = "remixarcgroup7cst8918"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Managed Redis DB to cache weather API data (in test and prod env)
resource "azurerm_redis_cache" "redis" {
  for_each = toset(["test", "prod"])

  name                = "remix-${each.key}-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
}
