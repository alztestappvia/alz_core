data "azurerm_client_config" "current" {}

data "azuread_service_principal" "vendor" {
  display_name = "id-${var.root_id}-vendor"
}
