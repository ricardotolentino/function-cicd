output "tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "app_id" {
  value = azuread_application.app_registration.application_id
}

output "secret" {
  value = nonsensitive(azuread_application_password.secret.value)
}
