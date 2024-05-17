data "terraform_remote_state" "connectivity" {
  backend = "azurerm"

  config = {
    use_azuread_auth     = true
    use_oidc             = var.use_oidc
    storage_account_name = var.connectivity_storage_account_name
    container_name       = "tfstate"
    key                  = "connectivity.tfstate"
  }
}

data "terraform_remote_state" "management" {
  backend = "azurerm"

  config = {
    use_azuread_auth     = true
    use_oidc             = var.use_oidc
    storage_account_name = var.management_storage_account_name
    container_name       = "tfstate"
    key                  = "management.tfstate"
  }
}

data "terraform_remote_state" "identity" {
  backend = "azurerm"

  config = {
    use_azuread_auth     = true
    use_oidc             = var.use_oidc
    storage_account_name = var.identity_storage_account_name
    container_name       = "tfstate"
    key                  = "identity.tfstate"
  }
}
