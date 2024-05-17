provider "azurerm" {
  skip_provider_registration = true
  use_oidc                   = var.use_oidc
  storage_use_azuread        = true
  features {}
}
provider "azuread" {
  use_oidc = var.use_oidc
}

provider "azapi" {
  use_oidc = var.use_oidc
}

provider "time" {}
