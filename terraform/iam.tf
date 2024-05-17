resource "azurerm_role_assignment" "vendor_management_group_contributor" {
  scope                = keys(module.enterprise_scale.azurerm_management_group.level_1)[0]
  role_definition_name = "Management Group Contributor"
  principal_id         = data.azuread_service_principal.vendor.object_id
}
