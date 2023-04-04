# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.50.0"
    }
  }

  required_version = "~> 1.4.0"

  #  backend "azurerm" {
  #    resource_group_name  = ""
  #    storage_account_name = ""
  #    container_name       = ""
  #    key                  = ""
  #  }
}

provider "azurerm" {
  features {}
}