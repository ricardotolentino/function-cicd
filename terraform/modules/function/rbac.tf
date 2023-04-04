resource "azuread_application" "app_registration" {
  display_name = "spn${local.name_suffix}"
}

resource "azuread_service_principal" "enterprise_app" {
  application_id = azuread_application.app_registration.application_id
  use_existing   = false
}

resource "azurerm_role_assignment" "rg_role_assignment" {
  principal_id         = azuread_service_principal.enterprise_app.object_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.rg.id
}

resource "azuread_application_password" "secret" {
  display_name          = "tf-secret"
  application_object_id = azuread_application.app_registration.object_id
}
