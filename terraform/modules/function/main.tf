resource "azurerm_resource_group" "rg" {
  name     = "rg${local.name_suffix}"
  location = var.location
}

resource "random_integer" "random_storage_account_int" {
  keepers = {
    storage_account_name = var.storage_account_prefix
  }
  min = 0
  max = 9999
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.storage_account_prefix}${format("%04d", random_integer.random_storage_account_int.id)}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "app_plan" {
  name                = "plan${local.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "function" {
  name                = "func${local.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }


}
