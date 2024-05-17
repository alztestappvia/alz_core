terraform {
  required_version = ">= 1.3.1"
  backend "azurerm" {
    use_azuread_auth = true
    use_oidc         = true
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.65.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.40.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.7.0"
    }
  }
}
