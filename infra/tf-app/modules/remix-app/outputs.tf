output "acr_login_server" {
  value = azurerm_container_registry.acrgroup7.login_server
}

output "redis_test_hostname" {
  value = azurerm_redis_cache.redis["test"].hostname
}

output "redis_test_primary_key" {
  value = azurerm_redis_cache.redis["test"].primary_access_key
}

output "redis_prod_hostname" {
  value = azurerm_redis_cache.redis["prod"].hostname
}

output "redis_prod_primary_key" {
  value = azurerm_redis_cache.redis["prod"].primary_access_key
}
